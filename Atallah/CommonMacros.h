#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define LIGHT_BEIGE UIColorFromRGB(0xA9987D)
#define DARK_BEIGE UIColorFromRGB(0xD2C3A7)



