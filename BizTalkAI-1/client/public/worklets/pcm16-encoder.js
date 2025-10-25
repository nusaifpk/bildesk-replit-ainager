class PCM16Encoder extends AudioWorkletProcessor {
  process(inputs) {
    const input = inputs[0];
    if (!input || !input[0]) return true;
    
    const channel = input[0]; // mono input
    const pcm = new Int16Array(channel.length);
    
    // Convert Float32 [-1,1] to Int16LE
    for (let i = 0; i < channel.length; i++) {
      const sample = Math.max(-1, Math.min(1, channel[i]));
      pcm[i] = sample < 0 ? sample * 0x8000 : sample * 0x7fff;
    }
    
    // Send binary data to main thread
    this.port.postMessage(pcm.buffer, [pcm.buffer]);
    return true;
  }
}

registerProcessor("pcm16-encoder", PCM16Encoder);


