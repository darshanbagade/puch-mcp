#!/usr/bin/env python3
"""
Test script for MCP server deployment
Usage: python test_deployment.py <server_url>
Example: python test_deployment.py https://your-app.railway.app
"""

import sys
import httpx
import json
import asyncio

async def test_mcp_server(base_url: str):
    """Test MCP server functionality"""
    
    # Ensure URL ends with /mcp/
    if not base_url.endswith('/'):
        base_url += '/'
    if not base_url.endswith('mcp/'):
        base_url += 'mcp/'
    
    print(f"🧪 Testing MCP server at: {base_url}")
    
    headers = {
        "Authorization": "Bearer debugger0007",
        "Content-Type": "application/json",
        "Accept": "application/json, text/event-stream"
    }
    
    try:
        async with httpx.AsyncClient(timeout=30.0) as client:
            # Test 1: Initialize connection
            print("\n1️⃣ Testing initialization...")
            init_payload = {
                "jsonrpc": "2.0",
                "id": 1,
                "method": "initialize",
                "params": {
                    "protocolVersion": "1.0.0",
                    "capabilities": {"tools": {}}
                }
            }
            
            response = await client.post(base_url, json=init_payload, headers=headers)
            print(f"   Status: {response.status_code}")
            if response.status_code == 200:
                print("   ✅ Initialization successful")
            else:
                print(f"   ❌ Initialization failed: {response.text}")
                return False
            
            # Test 2: List tools
            print("\n2️⃣ Testing tools list...")
            tools_payload = {
                "jsonrpc": "2.0",
                "id": 2,
                "method": "tools/list",
                "params": {}
            }
            
            response = await client.post(base_url, json=tools_payload, headers=headers)
            print(f"   Status: {response.status_code}")
            if response.status_code == 200:
                result = response.json()
                if "result" in result and "tools" in result["result"]:
                    tools = result["result"]["tools"]
                    print(f"   ✅ Found {len(tools)} tools: {[t['name'] for t in tools]}")
                else:
                    print(f"   ⚠️ Unexpected response format: {result}")
            else:
                print(f"   ❌ Tools list failed: {response.text}")
                return False
            
            # Test 3: Call price finder tool (with mock data)
            print("\n3️⃣ Testing price finder tool...")
            tool_payload = {
                "jsonrpc": "2.0",
                "id": 3,
                "method": "tools/call",
                "params": {
                    "name": "find_product_price",
                    "arguments": {
                        "image_id": "test_image_123",
                        "product_url": None
                    }
                }
            }
            
            response = await client.post(base_url, json=tool_payload, headers=headers)
            print(f"   Status: {response.status_code}")
            if response.status_code == 200:
                result = response.json()
                if "result" in result:
                    print("   ✅ Price finder tool executed successfully")
                    # Print summary of result
                    tool_result = result["result"]
                    if "content" in tool_result and tool_result["content"]:
                        content = tool_result["content"][0]["text"]
                        if "product_name" in content:
                            print(f"   📦 Sample product detected in response")
                else:
                    print(f"   ⚠️ Tool executed but unexpected format: {result}")
            else:
                print(f"   ❌ Tool call failed: {response.text}")
                return False
            
            print("\n🎉 All tests passed! MCP server is working correctly.")
            return True
            
    except Exception as e:
        print(f"\n💥 Test failed with error: {str(e)}")
        return False

def main():
    if len(sys.argv) != 2:
        print("Usage: python test_deployment.py <server_url>")
        print("Example: python test_deployment.py https://your-app.railway.app")
        sys.exit(1)
    
    server_url = sys.argv[1]
    success = asyncio.run(test_mcp_server(server_url))
    
    if not success:
        sys.exit(1)

if __name__ == "__main__":
    main()
