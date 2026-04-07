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

**Files Created**:
- `/app/frontend/src/data/mock.js` - Mock data for all game servers
- `/app/frontend/src/pages/LandingPage.jsx` - Main landing page component
- `/app/frontend/src/styles/LandingPage.css` - Neon-tech design system styles
- `/app/frontend/src/App.js` - Updated routing
- `/app/frontend/src/App.css` - Base styles

**Features Implemented**:
1. ✓ Fixed navigation with smooth scrolling
2. ✓ Hero section with gaming setup background image
3. ✓ Minecraft server section with:
   - Server information card
   - Copyable server IP
   - Player count display (mock: 45/100)
   - Features list
   - "View Live Map" button (links to Squaremap)
4. ✓ Ark Survival Ascended section with:
   - Server information
   - Copyable server IP
   - Player count display (mock: 28/70)
   - Accordion component for multiple maps (The Island, Scorched Earth)
   - Each map shows Server Features and Installed Mods
5. ✓ Palworld coming soon section with:
   - Construction icon
   - Coming soon message
   - Estimated launch date (Q2 2025)
   - Discord CTA for updates
6. ✓ Footer with quick links and community section
7. ✓ Responsive design (mobile, tablet, desktop)
8. ✓ Copy to clipboard functionality for server IPs
9. ✓ Smooth animations and hover effects
10. ✓ Neon-tech design system fully implemented

**Design Highlights**:
- Dark background (#1a1c1b) with lime green accents (#d9fb06)
- Pill-shaped buttons with hover animations
- High contrast text for readability
- Gaming-themed hero image with overlay
- Accordion component for organized mod/feature lists
- Glassmorphic effects on cards
- Mobile-optimized navigation

## Prioritized Backlog

### P0 Features (Required for Production)
1. **Content Customization**:
   - Replace "Epic Gaming Community" with actual community name
   - Update Discord invite link
   - Update Squaremap URL for Minecraft
   - Update server IPs for all games
   - Update Ark features and mods lists
   - Update Palworld launch date

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
1. Gather actual content from user:
   - Community name and branding
   - Discord invite link
   - Squaremap URL
   - Server IPs for all games
   - Complete Ark features/mods lists
   - Palworld launch date
2. Update mock.js with real data
3. Test all links and functionality
4. Optional: Add backend for dynamic player counts
5. Optional: Deploy to production server

## Notes
- All data is currently MOCKED in `/app/frontend/src/data/mock.js`
- Easy to update placeholder content
- Design follows neon-tech guidelines strictly
- No backend required for static version
- Can run on local server as mentioned by user
