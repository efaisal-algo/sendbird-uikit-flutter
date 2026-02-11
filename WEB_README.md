# Sendbird UIKit Flutter - Web Configuration

This project has been configured to run on web platforms. Here's how to test and deploy your Sendbird UIKit Flutter application on the web.

## Prerequisites

- Flutter SDK (3.3.0 or higher)
- Chrome browser for testing
- Sendbird App ID and User ID

## Quick Start

### 1. Configure Your Sendbird Credentials

Before running the application, you need to update the Sendbird credentials in `lib/main.dart`:

```dart
await SendbirdUIKit.init(appId: 'YOUR_APP_ID');  // Replace with your actual App ID
await SendbirdUIKit.connect('YOUR_USER_ID');      // Replace with your actual User ID
```

### 2. Run in Development Mode

To run the application in development mode with hot reload:

```bash
flutter run -d chrome --web-port=8080
```

This will:
- Launch Chrome browser
- Start the development server on port 8080
- Enable hot reload for faster development

### 3. Build for Production

To build the application for production deployment:

```bash
flutter build web
```

The built files will be available in the `build/web` directory.

## Web-Specific Features

### Responsive Design
The application is configured with responsive design that works well on:
- Desktop browsers
- Mobile browsers
- Tablet browsers

### PWA Support
The application includes Progressive Web App (PWA) configuration:
- `web/manifest.json` - PWA manifest
- `web/index.html` - Optimized HTML template
- Service worker support for offline functionality

### Web Assets
All assets are properly configured for web deployment:
- Fonts are optimized and tree-shaken
- Images are compressed
- Icons are properly sized for different screen densities

## Deployment Options

### 1. Static Hosting (Firebase, Netlify, Vercel)

```bash
# Build the application
flutter build web

# Deploy the build/web directory to your hosting service
```

### 2. Web Server Deployment

```bash
# Build the application
flutter build web

# Serve the build/web directory with any web server
# Example with Python:
cd build/web
python -m http.server 8000
```

### 3. Docker Deployment

Create a `Dockerfile` in your project root:

```dockerfile
FROM nginx:alpine
COPY build/web /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
```

## Configuration Files

### web/index.html
- Main HTML template
- Meta tags for mobile optimization
- PWA configuration

### web/manifest.json
- PWA manifest
- App name, icons, and theme colors
- Display mode and orientation settings

### web/icons/
- App icons for different screen sizes
- Maskable icons for Android
- Apple touch icons for iOS

## Troubleshooting

### Common Issues

1. **Font Loading Issues**
   - Ensure all required fonts are included in `pubspec.yaml`
   - Check that font files exist in the `assets/fonts/` directory

2. **CORS Issues**
   - Make sure your Sendbird App ID is configured for web domains
   - Check that your hosting domain is whitelisted in Sendbird dashboard

3. **Build Errors**
   - Run `flutter clean` and `flutter pub get` before building
   - Ensure all dependencies are compatible with web platform

### Performance Optimization

1. **Tree Shaking**
   - Fonts are automatically tree-shaken to reduce bundle size
   - Unused code is removed during build

2. **Asset Optimization**
   - Images are compressed during build
   - Fonts are optimized for web delivery

## Development Tips

1. **Hot Reload**
   - Use `flutter run -d chrome` for development
   - Hot reload works seamlessly with web platform

2. **Debugging**
   - Use Chrome DevTools for debugging
   - Flutter Inspector works in web development mode

3. **Testing**
   - Test on different screen sizes
   - Verify PWA functionality
   - Check offline behavior

## Next Steps

1. Replace `YOUR_APP_ID` and `YOUR_USER_ID` with actual Sendbird credentials
2. Customize the UI theme and colors
3. Add your own branding and styling
4. Configure push notifications for web
5. Set up analytics and monitoring

## Support

For more information about Sendbird UIKit Flutter:
- [Documentation](https://sendbird.com/docs/chat/uikit/v3/flutter/overview)
- [GitHub Repository](https://github.com/sendbird/sendbird-uikit-flutter)
- [Sendbird Support](https://sendbird.com/support)
