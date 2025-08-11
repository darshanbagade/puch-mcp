# 🔍 Product Price Finder MCP Server

An intelligent MCP (Model Context Protocol) server that analyzes product images and finds real-time pricing from multiple e-commerce platforms using AI.

## 🚀 Features

- **AI-Powered Image Analysis**: Uses Google Gemini 2.0 Flash to identify products from images
- **Multi-Platform Price Search**: Searches Amazon, Flipkart, eBay for competitive pricing  
- **WhatsApp Integration**: Works seamlessly with Puch AI WhatsApp bots
- **Secure Authentication**: Bearer token-based access control
- **Intelligent Fallback**: Mock analysis when image fetch fails
- **Debug Mode**: Comprehensive logging for troubleshooting

## 🛠️ Quick Setup

### 1. Clone Repository
```bash
git clone https://github.com/darshanbagade/puch-mcp.git
cd puch-mcp
```

### 2. Environment Configuration
```bash
# Copy the example environment file
cp .env.example .env

# Edit .env with your actual values
# Required variables:
AUTH_TOKEN=your_secure_token_here
GEMINI_API_KEY=your_gemini_api_key
MY_NUMBER=your_phone_number
DEBUG=true
```

### 3. Install Dependencies
```bash
pip install -r requirements.txt
```

### 4. Run Server
```bash
python main.py
```

The server will start on `http://localhost:8086/mcp/`

## 🌐 Deployment Options

### Railway (Recommended - Free & Easy)
1. Push code to GitHub
2. Connect repository at [railway.app](https://railway.app)
3. Set environment variables:
   - `AUTH_TOKEN=your_secure_token`
   - `GEMINI_API_KEY=your_gemini_key`
   - `MY_NUMBER=your_phone_number`
   - `DEBUG=false`
4. Deploy automatically!

### Render (Free Tier Available)
1. Connect GitHub repository to [render.com](https://render.com)
2. Use `render.yaml` configuration
3. Set environment variables in dashboard
4. Deploy with one click

### Heroku
```bash
heroku create your-app-name
heroku config:set AUTH_TOKEN=your_token
heroku config:set GEMINI_API_KEY=your_key
heroku config:set MY_NUMBER=your_number
git push heroku main
```

### Docker Deployment
```bash
# Build and run locally
docker build -t mcp-server .
docker run -p 8086:8086 --env-file .env mcp-server

# Or use docker-compose
docker-compose up -d
```

### AWS EC2 / VPS
```bash
# Upload files and run deployment script
chmod +x deploy.sh
sudo ./deploy.sh
```

## 🧪 Testing Your Deployment

Test your deployed server:
```bash
python test_deployment.py https://your-server-url.com
```

## 🔒 Security & Best Practices

- ✅ `.env` files are excluded from git (sensitive data protected)
- ✅ Use strong, unique auth tokens in production
- ✅ Regularly rotate API keys
- ✅ Enable HTTPS in production environments
- ✅ Never commit sensitive credentials to version control
   
   Edit `.env` with your details:
   ```env
   AUTH_TOKEN=your_secret_bearer_token
   MY_NUMBER=919876543210
   GEMINI_API_KEY=your_gemini_api_key
   ```

3. **Run the server:**
   ```bash
   python main.py
   ```

### Deployment

#### Using ngrok (Local)
```bash
ngrok http 8086
```

#### Using Render/Docker (Cloud)
Deploy to Render.com or similar cloud platform.

## Connecting to Puch AI

1. Start the MCP server
2. Expose via ngrok or deploy to cloud
3. Connect in Puch AI:
   ```
   /mcp connect https://your-domain.ngrok.app/mcp your_bearer_token
   ```

## Usage

- **Image Mode:** Upload any product image to get instant price analysis
- **Link Mode:** Paste Amazon/Flipkart/eBay URLs to get current pricing
- **Results:** Get product details, current price, and purchase links

## License

MIT License
