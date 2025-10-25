# Render Deployment Guide for Hainager

## Prerequisites
- GitHub repository with your code
- Render account (free tier available)
- Environment variables ready

## Step 1: Prepare Your Repository

### 1.1 Commit All Changes
```bash
git add .
git commit -m "Prepare for Render deployment"
git push origin main
```

### 1.2 Verify Build Scripts
Your `package.json` should have:
- `build`: Builds both client and server
- `start`: Starts the production server
- `build:client`: Builds only the client (for static deployment)

## Step 2: Create Render Account and Connect Repository

### 2.1 Sign Up for Render
1. Go to [render.com](https://render.com)
2. Sign up with GitHub
3. Connect your GitHub account

### 2.2 Create New Web Service
1. Click "New +" → "Web Service"
2. Connect your repository
3. Select your repository from the list

## Step 3: Configure Web Service

### 3.1 Basic Settings
- **Name**: `hainager-app` (or your preferred name)
- **Environment**: `Node`
- **Region**: Choose closest to your users
- **Branch**: `mobile-app` (your mobile-app branch)
- **Root Directory**: Leave empty (uses root)

### 3.2 Build & Deploy Settings
- **Build Command**: `npm install && npm run build`
- **Start Command**: `npm start`
- **Node Version**: `18` or `20`

### 3.3 Advanced Settings
- **Auto-Deploy**: `Yes`
- **Health Check Path**: `/` (optional)

## Step 4: Set Environment Variables

### 4.1 Required Variables
In Render dashboard → Environment:
```
NODE_ENV=production
SESSION_SECRET=your_random_secret_key_here
```

### 4.2 Optional Variables (if using)
```
# Database (if using Neon/PostgreSQL)
DATABASE_URL=your_neon_database_url

# OpenAI (if using AI features)
OPENAI_API_KEY=your_openai_api_key

# Other API keys
API_KEY=your_api_key
```

### 4.3 Generate Session Secret
```bash
# Generate a random secret
node -e "console.log(require('crypto').randomBytes(32).toString('hex'))"
```

## Step 5: Deploy

### 5.1 Deploy Service
1. Click "Create Web Service"
2. Render will automatically:
   - Clone your repository
   - Install dependencies
   - Build your application
   - Deploy to a public URL

### 5.2 Monitor Deployment
- Watch the build logs
- Check for any errors
- Wait for "Deploy successful" message

## Step 6: Configure Custom Domain (Optional)

### 6.1 Add Custom Domain
1. Go to your service settings
2. Click "Custom Domains"
3. Add your domain (e.g., `hainager.com`)

### 6.2 Update DNS
1. Render will provide DNS records
2. Update your domain's DNS settings
3. Wait for propagation (5-10 minutes)

## Step 7: Update PWA/TWA Configuration

### 7.1 Update Manifest URLs
After deployment, update your TWA configuration:
```json
{
  "webManifestUrl": "https://your-render-app.onrender.com/manifest.json",
  "iconUrl": "https://your-render-app.onrender.com/icon-512x512.png"
}
```

### 7.2 Regenerate TWA
```bash
# Update the config with your new Render URL
bubblewrap init --manifest=https://your-render-app.onrender.com/manifest.json --directory=hainager-twa
```

## Step 8: Monitor and Maintain

### 8.1 Monitor Performance
- Check Render dashboard for metrics
- Monitor response times
- Set up alerts for downtime

### 8.2 Automatic Deployments
- Every push to mobile-app branch triggers deployment
- Monitor build logs for issues
- Rollback if needed

## Troubleshooting

### Common Issues

#### Build Failures
- Check Node.js version compatibility
- Verify all dependencies are in `package.json`
- Check for TypeScript errors

#### Runtime Errors
- Check environment variables
- Verify database connections
- Check server logs in Render dashboard

#### PWA Issues
- Ensure manifest.json is accessible
- Check service worker registration
- Verify HTTPS (Render provides this automatically)

### Useful Commands
```bash
# Check build locally
npm run build

# Test production build locally
npm start

# Check for TypeScript errors
npm run check
```

## Render Pricing

### Free Tier
- 750 hours/month
- Sleeps after 15 minutes of inactivity
- Perfect for development/testing

### Paid Plans
- $7/month for always-on service
- Better performance
- Custom domains
- More resources

## Next Steps After Deployment

1. **Test your deployed app**: Visit your Render URL
2. **Update TWA configuration**: Use your new Render URL
3. **Generate new Android APK**: Run your TWA script with new URL
4. **Set up monitoring**: Configure alerts and monitoring
5. **Custom domain**: Add your own domain if desired

## Support

- **Render Documentation**: [render.com/docs](https://render.com/docs)
- **Render Community**: [community.render.com](https://community.render.com)
- **GitHub Issues**: Use your repository's issue tracker

Your app will be available at: `https://your-app-name.onrender.com`
