# SignTaxi - UI Layout Reference Guide

## 📐 **PASSENGER HOME SCREEN LAYOUT**

```
┌─────────────────────────────────────┐
│  🏠 SignTaxi    🔔    👤           │  ← FIXED APP BAR (Custom)
│  (Deep Blue Background)             │     Height: 60dp
├─────────────────────────────────────┤
│                                     │
│  📍 Current Location                │  ← Gradient Header
│  123 Main Street, City              │     (Blue to Teal)
│                                     │
├─────────────────────────────────────┤
│                                     │
│  ┌─────────────────────────────────┐│  ← BOOKING CARD
│  │ Book Your Ride                  ││     (White, Elevated)
│  ├─────────────────────────────────┤│
│  │ ● Pickup location...             ││
│  │      ▲                          ││  ← Swap Button
│  │      ▼                          ││
│  │ 📍 Where to?                    ││
│  └─────────────────────────────────┘│
│                                     │
│  Select Vehicle Type                │  ← VEHICLE CARDS
│  ┌────────┐ ┌────────┐ ┌────────┐  │
│  │ 🚗     │ │ 🚗     │ │ 🚗     │  │
│  │ Mini   │ │ Sedan  │ │ SUV    │  │
│  │ ₹100   │ │ ₹150   │ │ ₹200   │  │
│  └────────┘ └────────┘ └────────┘  │
│                                     │
│  ┌─────────────────────────────────┐│  ← PROMO BANNER
│  │ 🏷️  SAVE20 - Get 20% Discount    ││     (Orange Background)
│  └─────────────────────────────────┘│
│                                     │
│  ┌─────────────────────────────────┐│  ← BOOK NOW BUTTON
│  │      💙 BOOK NOW 💙             ││     (Blue, Large)
│  └─────────────────────────────────┘│
│                                     │
├─────────────────────────────────────┤
│  🏠 Home  | 🕐 Rides | ❤️  Saved | ≡ Menu  │  ← FIXED BOTTOM NAV
└─────────────────────────────────────┘        Height: Adaptive
```

---

## 📐 **DRIVER HOME SCREEN LAYOUT**

```
┌─────────────────────────────────────┐
│  🚗 Driver Dashboard          ⚙️    │  ← FIXED APP BAR
│  (Deep Blue Background)             │     Height: 60dp
├─────────────────────────────────────┤
│                                     │
│  ┌─────────────────────────────────┐│  ← STATUS CARD
│  │ You are                     ✓   ││     (Gradient)
│  │ ONLINE                          ││
│  └─────────────────────────────────┘│
│                                     │
│  ┌────────────────┐ ┌────────────────┐  ← STATS (2 Rows × 2 Cols)
│  │ 📈 Total      │ │ 🚗 Rides      │
│  │ Earnings      │ │ Today         │
│  │ ₹2,450        │ │ 12            │
│  └────────────────┘ └────────────────┘
│  ┌────────────────┐ ┌────────────────┐
│  │ ⭐ Rating     │ │ ✓ Completed   │
│  │ 4.8⭐        │ │ 345           │
│  └────────────────┘ └────────────────┘
│                                     │
│  Active Ride Request                │
│  ┌─────────────────────────────────┐│  ← RIDE REQUEST CARD
│  │ John Doe                   ₹250 ││     (White, Elevated)
│  │                                 ││
│  │ 📍 123 Main Street, Downtown    ││
│  │ 🚩 Airport Terminal 2           ││
│  │                                 ││
│  │ ┌──────────────┐ ┌──────────────┐││
│  │ │ ✓ ACCEPT     │ │ ✗ DECLINE   ││
│  │ └──────────────┘ └──────────────┘││
│  └─────────────────────────────────┘│
│                                     │
│  Documents                          │  ← DOCUMENT LIST
│  ✓ License       ✓ Verified        │
│  ✓ Insurance     ✓ Verified        │
│  ⏳ Registration ⏳ Pending         │
│                                     │
├─────────────────────────────────────┤
│ 🏠 Home | 💰 Earnings | 📄 Docs | ≡ Menu  │  ← FIXED BOTTOM NAV
└─────────────────────────────────────┘
```

---

## 🎨 **COLOR DISTRIBUTION**

### **Primary Blue (#1E3A8A)**
- ✅ App Bar Background
- ✅ Bottom Navigation Active State
- ✅ Primary Action Buttons
- ✅ Text Accents
- ✅ Card Borders (Selected State)

### **Secondary Teal (#0891B2)**
- ✅ Gradient Header (Mixed with Primary)
- ✅ Status Indicators
- ✅ Secondary CTAs
- ✅ Accent Elements

### **Cyan Accent (#06B6D4)**
- ✅ Highlight Elements
- ✅ Vehicle Selection Cards
- ✅ Interactive States

### **Light Background (#F8FAFC)**
- ✅ Page/Screen Background
- ✅ Creates visual separation

### **White (#FFFFFF)**
- ✅ Card Backgrounds
- ✅ Input Fields
- ✅ Navigation Items (Inactive)
- ✅ Text on colored backgrounds

### **Dark Text (#1E293B)**
- ✅ Primary Text Content
- ✅ Card Titles
- ✅ Labels

### **Status Colors**
- 🟢 **Green (#10B981)** - Success, Verified, Available
- 🔴 **Red (#EF4444)** - Decline, Error, Danger
- 🟠 **Orange (#F59E0B)** - Pending, Warning, Promo
- 🔵 **Blue (#3B82F6)** - Info, Links

---

## 📏 **COMPONENT SIZES & SPACING**

### **App Bar**
- Height: 60dp
- Horizontal Padding: 16dp
- Icon Size: 24dp (actions) / 18dp (back)

### **Bottom Navigation Bar**
- Height: Adaptive (usually 60-80dp)
- Item Width: Equal distribution
- Icon Size: 24dp
- Label Font Size: 10sp

### **Cards**
- Border Radius: 16dp (lg)
- Padding: 16dp (md)
- Shadow: Elevation 4-8

### **Buttons**
- Height: 48-56dp
- Border Radius: 8dp (md)
- Padding: 16dp horizontal, 16dp vertical

### **Input Fields**
- Height: 48-56dp
- Border Radius: 8dp (md)
- Padding: 16dp all sides

### **Spacing Scale**
```
xs: 4dp
sm: 8dp
md: 16dp  ← Most common
lg: 24dp
xl: 32dp
xxl: 48dp
```

---

## 🔄 **INTERACTION STATES**

### **Bottom Navigation Item States**

**Inactive:**
- Icon Color: Gray[400]
- Background: Transparent
- Label Color: Gray[400]
- Font Weight: 500

→ **Active (Tap):**
- Icon Color: Primary Blue
- Background: Primary Blue @ 10% opacity
- Label Color: Primary Blue
- Font Weight: 600
- Animation: 300ms smooth transition

### **Buttons**

**Enabled:**
- Background: Primary Color
- Text: White
- Elevation: 4
- Cursor: Pointer

→ **Pressed:**
- Elevation: 8
- Opacity: Slightly reduced
- Animation: Ripple effect

→ **Disabled:**
- Background: Gray[300]
- Text: Gray[500]
- No elevation
- Cursor: Not allowed

### **Input Fields**

**Default:**
- Border: Gray @ 30% opacity
- Background: White
- Focus Effect: None

→ **Focused:**
- Border: Primary Blue (Width: 2dp)
- Shadow: Subtle elevation
- Cursor: Blue

---

## ✨ **SHADOW EFFECTS (Elevation)**

```
xs: Box shadow 1px, 3px | 1px, 2px
sm: Box shadow 4px, 6px @ 10% opacity
md: Box shadow 4px, 6px @ 10% opacity  ← Cards
lg: Box shadow 10px, 25px @ 10% opacity
```

---

## 📱 **RESPONSIVE BEHAVIOR**

### **Portrait Mode (Mobile)**
- Full width cards with 16dp margins
- Single column layout
- Bottom navbar visible

### **Landscape Mode**
- 2-column grid for stats
- Optimized card width
- Bottom navbar still fixed

### **Tablet (iPad)**
- Maximum container width: 800dp
- Centered with side padding
- Larger touch targets

---

## 🎯 **ACCESSIBILITY FEATURES**

✅ **Color Contrast**
- All text meets WCAG AA standards
- Color is not the only differentiator
- Icons accompany text labels

✅ **Touch Targets**
- Minimum 48dp × 48dp for all interactive elements
- Clear visual feedback

✅ **Typography**
- Clear font hierarchy
- Readable font sizes (min 12sp)
- Adequate line spacing

✅ **Navigation**
- Clear navigation patterns
- Visible active states
- Back button support

---

## 🚀 **PERFORMANCE OPTIMIZATIONS**

1. **Scrollable Content** - Content scrolls above fixed navbar
2. **Lazy Loading** - Cards render only visible items
3. **Provider Pattern** - Efficient state management
4. **Vector Graphics** - Material icons (no heavy images)
5. **Theme Caching** - Colors loaded once and reused

