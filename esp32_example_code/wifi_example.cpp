#include <Arduino.h>
#include <WiFi.h>
#include <ESPAsyncWebServer.h>

// Replace with your network credentials
const char *ssid = "ESP32_Flutter_Example";
const char *password = "12345678";

// Create AsyncWebServer object on port 80
AsyncWebServer server(80);

bool printHello = false;
void handleHello()
{
  Serial.println("handling Hello request");
  if (printHello)
  {
    printHello = false;
  }
  else
  {
    printHello = true;
  }
}

void setup()
{
  // Serial port for debugging purposes
  Serial.begin(9600);

  // Create SoftAP
  WiFi.softAP(ssid, password);
  IPAddress IP = WiFi.softAPIP();
  Serial.print("AP IP address: ");
  Serial.println(IP);

  // Route for root / web page
  server.on("/hello", HTTP_POST, [](AsyncWebServerRequest *request)
            {
              handleHello();
              request->send(200, "text/plain", "Hello, world"); });

  // Start server
  server.begin();
}

void loop()
{
  delay(1);
}