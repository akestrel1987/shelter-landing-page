# Gaming Community Landing Page - Product Requirements Document

## Original Problem Statement
Build a landing page for Minecraft, Ark Survival Ascended, and Palworld Discord Community Servers with:
- Minecraft: Link to Squaremap page (nested/embedded)
- Ark: Features and mods list for multiple maps
- Palworld: Under construction/coming soon page

## User Personas
- **Gaming Community Members**: Looking for server information, IP addresses, and features
- **New Players**: Discovering the community and looking to join
- **Server Administrators**: Managing and showcasing their gaming servers

## Core Requirements (Static)
1. **Navigation**: Fixed header with smooth scroll to sections + Discord CTA
2. **Hero Section**: Full-screen hero with community branding and primary CTA
3. **Minecraft Section**: Server info, IP address (copyable), player count, features list, and Squaremap link
4. **Ark Section**: Server info, IP address (copyable), player count, expandable accordion for multiple maps with features/mods
5. **Palworld Section**: Coming soon card with estimated launch date and Discord CTA
6. **Footer**: Quick links and community links
7. **Design**: Neon-tech design system (dark backgrounds, lime green accents, high contrast)
8. **Responsive**: Mobile, tablet, and desktop layouts

## Tech Stack
- **Frontend**: React with shadcn/ui components
- **Design System**: Neon-tech (black/dark gray backgrounds, lime green #d9fb06 primary)
- **Components Used**: Button, Card, Accordion (shadcn/ui)
- **Icons**: lucide-react

## What's Been Implemented (December 2025)

### Phase 1: Frontend with Mock Data ✓
**Date**: December 2025

**Files Created/Modified**:
- `/app/frontend/src/data/mock.js` - Mock data with The Shelter branding and placeholders
- `/app/frontend/src/pages/LandingPage.jsx` - Main landing page component with game-specific sections
- `/app/frontend/src/styles/LandingPage.css` - Neon-tech design + game-specific color themes
- `/app/frontend/src/App.js` - Updated routing
- `/app/frontend/src/App.css` - Base styles

**Features Implemented**:
1. ✓ Fixed navigation with smooth scrolling and The Shelter branding
2. ✓ Hero section with gaming setup background
3. ✓ **Minecraft section (GREEN THEME)** with:
   - Official Minecraft green color palette (#7FB83B grass green)
   - **Bedrock Edition (PC)**:
     - Address: share-hollow.gl.at.ply.gg
     - Port: 25662
     - Direct IP: 147.185.221.17:25662
     - All with copyable buttons
   - **Bedrock Edition (Console)**:
     - Xbox Gamertag: ShelterArkMC
     - Instructions for Xbox Live Friends join
   - **Java Edition 1.21.1**:
     - Address: most-clarity.gl.joinmc.link
   - Server features list (cross-platform, active community, custom plugins)
   - "View Live Map" button linking to Squaremap
   - Green-themed card borders and hover effects
   - Organized edition sections for easy navigation
4. ✓ **Ark Survival Ascended section (CYAN/BLUE THEME)** with:
   - Official Ark cyan/blue color palette (#00D4FF bright cyan)
   - **Custom panel image** integrated at the top ("Come Relax" visual)
   - Server type badge: [NEW | ASA | PvPvE | MODDED | CROSSPLAY]
   - Complete server description
   - "How to Find Our Cluster" instructions box
   - **Available Maps Display**:
     - Main Maps (8): The Island, Center, Scorched Earth, Aberration, Extinction, Valguero, Ragnarok, Club Ark
     - DLC Maps (2): Lost Colony, Astraeos - displayed with orange badges
   - "Welcoming both new & seasoned players!" message box
   - **4 Organized Accordion Sections**:
     - Mods on the Whole Cluster (20 mods) - updated "Starter Pack" to active
     - Player Tweaks (11 adjustments)
     - Dino Tweaks (12 adjustments)
     - Other Server Tweaks (7 settings)
   - Cyan-themed card borders and glow effects
   - Orange accent for DLC map badges and server type badge
5. ✓ **Palworld section (BLUE/PURPLE THEME)** with:
   - Official Palworld blue/purple color palette
   - Construction icon
   - Coming soon message
   - Estimated launch: TBA
   - Purple gradient title effect
   - Discord CTA for updates
6. ✓ Footer with The Shelter branding and quick links
7. ✓ Responsive design (mobile, tablet, desktop)
8. ✓ Smooth animations and game-specific hover effects
9. ✓ Game-specific color theming for visual distinction

**Design Highlights**:
- Dark background (#1a1c1b) base with game-specific accent colors
- **Minecraft**: Grass green (#7FB83B) with dark green accents
- **Ark**: Bright cyan (#00D4FF) with teal and orange accents
- **Palworld**: Blue-to-purple gradient (#4A90E2 to #9B59B6)
- Each section has unique color borders, glows, and hover effects
- High contrast text for readability
- Gaming-themed hero image
- Mobile-optimized navigation

## Prioritized Backlog

### P0 Features (Required for Production)
1. **Content Customization**:
   - ✓ Community name updated to "The Shelter"
   - ✓ Discord invite link updated: https://discord.gg/NUuwfMQ9zD
   - ✓ Squaremap URL updated: thesheltercommunity.servegame.net/sheltermcmap
   - ✓ **Ark server details COMPLETE** with all mods, tweaks, and search instructions
   - ⏳ **NEEDED**: Minecraft server IP and features list
   - ⏳ **NEEDED**: Palworld estimated launch date

### P1 Features (High Priority Enhancements)
1. **Backend Integration**:
   - Real-time player count API integration
   - Server status monitoring (online/offline)
   - Dynamic content management
2. **Minecraft Enhancements**:
   - Embed Squaremap iframe/widget directly on page
   - Server uptime display
3. **Analytics**:
   - Track Discord join button clicks
   - Page view analytics
   - Section engagement metrics

### P2 Features (Nice to Have)
1. **Community Features**:
   - Server rules/guidelines section
   - Staff/admin showcase
   - Community events calendar
   - News/announcements section
2. **Enhanced Visuals**:
   - Game-specific background images for each section
   - Video backgrounds for hero section
   - Gallery/screenshots section
3. **SEO & Performance**:
   - Meta tags optimization
   - Open Graph tags for social sharing
   - Performance optimizations

## Next Tasks
1. **Optional Enhancement**:
   - Palworld estimated launch date (currently shows "TBA")
2. Test all functionality (copy buttons, links, navigation)
3. Deploy to thesheltercommunity.servegame.net
4. Optional: Add backend for dynamic player counts and server status

## Notes
- **Minecraft section is COMPLETE** with Bedrock PC/Console and Java 1.21.1 connection details
- **Ark section is COMPLETE** with all 20 mods, player/dino/other tweaks, 10 maps, and custom panel image
- **Palworld section** has coming soon message (launch date TBA)
- Game-specific color themes implemented:
  - Minecraft: Green (#7FB83B)
  - Ark: Cyan (#00D4FF) with orange accents
  - Palworld: Blue/Purple gradient
- All server connection details with copy-to-clipboard functionality
- Discord link active: https://discord.gg/NUuwfMQ9zD
- Custom Ark panel image adds visual appeal and branding
- No backend required for static version
- **Ready for deployment** to thesheltercommunity.servegame.net
