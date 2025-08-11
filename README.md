# Product Price Finder MCP Server

An AI-powered product price finder that analyzes product images and fetches real-time pricing from major e-commerce sites through the Model Context Protocol (MCP) for Puch AI.

## Features

- **Two Input Modes:**
  - Product Link Mode: Paste Amazon, Flipkart, or eBay product URLs for instant pricing
  - Image Upload Mode: Upload product images for AI analysis and price discovery

- **AI-Powered Product Recognition:**
  - Uses Gemini 2.0 Flash Vision API for advanced image analysis
  - Identifies product name, brand, model, and key features
  - Provides detailed product analysis with confidence scoring

- **Real-time Price Fetching:**
  - Scrapes current prices from major e-commerce sites
  - Searches multiple platforms for best price comparison
  - Returns direct purchase links and price ranges

- **Instant Results:**
  - Upload image → Get immediate price analysis
  - Paste URL → Get current pricing information
  - No guessing required - direct price lookup

## Setup

### Prerequisites
- Python 3.11 or higher
- Gemini API key (free tier available)

### Installation

1. **Clone and setup:**
   ```bash
   cd guess-the-price-mcp
   uv venv
   uv sync
   ```

2. **Configure environment:**
   ```bash
   cp .env.example .env
   ```
   
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
