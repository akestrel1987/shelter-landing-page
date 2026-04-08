import React, { useState } from 'react';
import { Button } from '../components/ui/button';
import { Card } from '../components/ui/card';
import {
  Accordion,
  AccordionContent,
  AccordionItem,
  AccordionTrigger,
} from '../components/ui/accordion';
import { 
  Users, 
  Sword, 
  Pickaxe, 
  MapPin, 
  Server, 
  ExternalLink,
  Construction,
  Calendar
} from 'lucide-react';
import { communityData, socialLinks } from '../data/mock';

const LandingPage = () => {
  const [copiedIp, setCopiedIp] = useState('');

  const copyToClipboard = (text, type) => {
    navigator.clipboard.writeText(text);
    setCopiedIp(type);
    setTimeout(() => setCopiedIp(''), 2000);
  };

  const scrollToSection = (id) => {
    document.getElementById(id)?.scrollIntoView({ behavior: 'smooth' });
  };

  return (
    <div className="landing-page">
      {/* Navigation */}
      <nav className="nav-bar">
        <div className="nav-container">
          <div className="nav-brand">{communityData.name}</div>
          <div className="nav-links">
            <button onClick={() => scrollToSection('minecraft')} className="nav-link">
              Minecraft
            </button>
            <button onClick={() => scrollToSection('ark')} className="nav-link">
              Ark
            </button>
            <button onClick={() => scrollToSection('palworld')} className="nav-link">
              Palworld
            </button>
            <a href={communityData.discordInvite} target="_blank" rel="noopener noreferrer">
              <Button className="btn-primary">Join Discord</Button>
            </a>
          </div>
        </div>
      </nav>

      {/* Hero Section */}
      <section className="hero-section">
        <div className="hero-background">
          <div className="hero-image-container">
            <img 
              src="https://images.unsplash.com/photo-1542751371-adc38448a05e?w=1920&q=80" 
              alt="Gaming setup"
              className="hero-image"
            />
          </div>
          <div className="hero-overlay"></div>
        </div>
        <div className="hero-content">
          <h1 className="hero-title">{communityData.name}</h1>
          <p className="hero-subtitle">{communityData.tagline}</p>
          <div className="hero-cta">
            <a href={communityData.discordInvite} target="_blank" rel="noopener noreferrer">
              <Button className="btn-primary btn-large">
                <Users className="btn-icon" />
                Join Our Community
              </Button>
            </a>
          </div>
        </div>
      </section>

      {/* Minecraft Section */}
      <section id="minecraft" className="game-section">
        <div className="section-container">
          <div className="section-header">
            <Pickaxe className="section-icon" />
            <h2 className="section-title">{communityData.minecraft.title}</h2>
          </div>
          
          <div className="game-grid">
            <Card className="game-card">
              <div className="card-content-main">
                <h3 className="card-title">Server Information</h3>
                <p className="card-description">{communityData.minecraft.description}</p>
                
                {/* Bedrock PC Section */}
                <div className="mc-edition-section">
                  <h4 className="mc-edition-title">
                    <Server size={20} />
                    Bedrock Edition (PC)
                  </h4>
                  <div className="server-ip-box">
                    <div className="ip-label">
                      <span>Address:</span>
                    </div>
                    <div className="ip-display">
                      <code>{communityData.minecraft.bedrockPC.address}</code>
                      <Button 
                        className="btn-secondary btn-small"
                        onClick={() => copyToClipboard(communityData.minecraft.bedrockPC.address, 'bedrock-address')}
                      >
                        {copiedIp === 'bedrock-address' ? 'Copied!' : 'Copy'}
                      </Button>
                    </div>
                    <div className="ip-label mt-2">
                      <span>Port:</span>
                    </div>
                    <div className="ip-display">
                      <code>{communityData.minecraft.bedrockPC.port}</code>
                      <Button 
                        className="btn-secondary btn-small"
                        onClick={() => copyToClipboard(communityData.minecraft.bedrockPC.port, 'bedrock-port')}
                      >
                        {copiedIp === 'bedrock-port' ? 'Copied!' : 'Copy'}
                      </Button>
                    </div>
                  </div>
                  
                  <div className="server-ip-box mt-3">
                    <div className="ip-label">
                      <span>Direct IP:</span>
                    </div>
                    <div className="ip-display">
                      <code>{communityData.minecraft.bedrockPC.directIP}:{communityData.minecraft.bedrockPC.port}</code>
                      <Button 
                        className="btn-secondary btn-small"
                        onClick={() => copyToClipboard(`${communityData.minecraft.bedrockPC.directIP}:${communityData.minecraft.bedrockPC.port}`, 'bedrock-direct')}
                      >
                        {copiedIp === 'bedrock-direct' ? 'Copied!' : 'Copy'}
                      </Button>
                    </div>
                  </div>
                </div>

                {/* Bedrock Console Section */}
                <div className="mc-edition-section">
                  <h4 className="mc-edition-title">
                    <Users size={20} />
                    Bedrock Edition (Console)
                  </h4>
                  <div className="console-instructions">
                    <p>{communityData.minecraft.bedrockConsole.instructions}</p>
                    <div className="gamertag-box">
                      <span className="gamertag-label">Xbox Gamertag:</span>
                      <code className="gamertag">{communityData.minecraft.bedrockConsole.gamertag}</code>
                      <Button 
                        className="btn-secondary btn-small"
                        onClick={() => copyToClipboard(communityData.minecraft.bedrockConsole.gamertag, 'gamertag')}
                      >
                        {copiedIp === 'gamertag' ? 'Copied!' : 'Copy'}
                      </Button>
                    </div>
                  </div>
                </div>

                {/* Java Section */}
                <div className="mc-edition-section">
                  <h4 className="mc-edition-title">
                    <Server size={20} />
                    Java Edition {communityData.minecraft.java.version}
                  </h4>
                  <div className="server-ip-box">
                    <div className="ip-label">
                      <span>Server Address:</span>
                    </div>
                    <div className="ip-display">
                      <code>{communityData.minecraft.java.address}</code>
                      <Button 
                        className="btn-secondary btn-small"
                        onClick={() => copyToClipboard(communityData.minecraft.java.address, 'java')}
                      >
                        {copiedIp === 'java' ? 'Copied!' : 'Copy'}
                      </Button>
                    </div>
                  </div>
                </div>

                <div className="feature-list">
                  <h4 className="feature-title">Features:</h4>
                  <ul className="features">
                    {communityData.minecraft.features.map((feature, index) => (
                      <li key={index}>{feature}</li>
                    ))}
                  </ul>
                </div>

                <a 
                  href={communityData.minecraft.squaremapUrl} 
                  target="_blank" 
                  rel="noopener noreferrer"
                  className="btn-link-full"
                >
                  <Button className="btn-primary btn-full minecraft-btn">
                    <MapPin className="btn-icon" />
                    View Live Map
                    <ExternalLink className="btn-icon" size={16} />
                  </Button>
                </a>
              </div>
            </Card>
          </div>
        </div>
      </section>

      {/* Ark Section */}
      <section id="ark" className="game-section section-alt">
        <div className="section-container">
          <div className="section-header">
            <Sword className="section-icon" />
            <h2 className="section-title">{communityData.ark.title}</h2>
          </div>

          <Card className="game-card ark-card">
            <div className="ark-hero-section">
              <img 
                src="https://customer-assets.emergentagent.com/job_game-portal-343/artifacts/pa7etvbd_Shelter%20Ark%20Paneledit.png"
                alt="The Shelter Ark - Come Relax"
                className="ark-panel-image"
              />
            </div>
            
            <div className="card-content-main">
              <div className="ark-subtitle">{communityData.ark.subtitle}</div>
              <p className="card-description">{communityData.ark.description}</p>
              
              <div className="server-search-box">
                <div className="search-label">
                  <Server size={20} />
                  <span>How to Find Our Cluster:</span>
                </div>
                <div className="search-instructions">
                  <p>{communityData.ark.searchInstructions}</p>
                </div>
              </div>

              <div className="ark-maps-section">
                <h3 className="maps-section-title">
                  <MapPin size={24} />
                  Available Maps
                </h3>
                
                <div className="maps-container">
                  <div className="maps-category">
                    <h4 className="maps-category-title">Main Maps ({communityData.ark.mainMaps.length})</h4>
                    <div className="maps-grid">
                      {communityData.ark.mainMaps.map((map, index) => (
                        <div key={index} className="map-badge">
                          {map}
                        </div>
                      ))}
                    </div>
                  </div>
                  
                  <div className="maps-category">
                    <h4 className="maps-category-title">DLC Maps ({communityData.ark.dlcMaps.length})</h4>
                    <div className="maps-grid">
                      {communityData.ark.dlcMaps.map((map, index) => (
                        <div key={index} className="map-badge map-badge-dlc">
                          {map}
                        </div>
                      ))}
                    </div>
                  </div>
                </div>
              </div>

              <div className="ark-welcome">
                <p>{communityData.ark.welcomeMessage}</p>
              </div>

              <div className="server-details-section">
                <h3 className="subsection-title">Server Details</h3>
                <Accordion type="single" collapsible className="maps-accordion">
                  
                  {/* Cluster Mods */}
                  <AccordionItem value="mods">
                    <AccordionTrigger className="accordion-trigger">
                      Mods on the Whole Cluster ({communityData.ark.clusterMods.length} Mods)
                    </AccordionTrigger>
                    <AccordionContent className="accordion-content">
                      <div className="detail-section">
                        <ul className="detail-list mods-grid">
                          {communityData.ark.clusterMods.map((mod, idx) => (
                            <li key={idx}>{mod}</li>
                          ))}
                        </ul>
                      </div>
                    </AccordionContent>
                  </AccordionItem>

                  {/* Player Tweaks */}
                  <AccordionItem value="player">
                    <AccordionTrigger className="accordion-trigger">
                      Player Tweaks ({communityData.ark.playerTweaks.length} Adjustments)
                    </AccordionTrigger>
                    <AccordionContent className="accordion-content">
                      <div className="detail-section">
                        <ul className="detail-list">
                          {communityData.ark.playerTweaks.map((tweak, idx) => (
                            <li key={idx}>{tweak}</li>
                          ))}
                        </ul>
                      </div>
                    </AccordionContent>
                  </AccordionItem>

                  {/* Dino Tweaks */}
                  <AccordionItem value="dino">
                    <AccordionTrigger className="accordion-trigger">
                      Dino Tweaks ({communityData.ark.dinoTweaks.length} Adjustments)
                    </AccordionTrigger>
                    <AccordionContent className="accordion-content">
                      <div className="detail-section">
                        <ul className="detail-list">
                          {communityData.ark.dinoTweaks.map((tweak, idx) => (
                            <li key={idx}>{tweak}</li>
                          ))}
                        </ul>
                      </div>
                    </AccordionContent>
                  </AccordionItem>

                  {/* Other Tweaks */}
                  <AccordionItem value="other">
                    <AccordionTrigger className="accordion-trigger">
                      Other Server Tweaks ({communityData.ark.otherTweaks.length} Adjustments)
                    </AccordionTrigger>
                    <AccordionContent className="accordion-content">
                      <div className="detail-section">
                        <ul className="detail-list">
                          {communityData.ark.otherTweaks.map((tweak, idx) => (
                            <li key={idx}>{tweak}</li>
                          ))}
                        </ul>
                      </div>
                    </AccordionContent>
                  </AccordionItem>

                </Accordion>
              </div>
            </div>
          </Card>
        </div>
      </section>

      {/* Palworld Section */}
      <section id="palworld" className="game-section">
        <div className="section-container">
          <div className="section-header">
            <Construction className="section-icon" />
            <h2 className="section-title">{communityData.palworld.title}</h2>
          </div>

          <Card className="game-card coming-soon-card">
            <div className="card-content-main coming-soon-content">
              <Construction size={80} className="construction-icon" />
              <h3 className="coming-soon-title">Coming Soon</h3>
              <p className="coming-soon-text">
                We're working hard to bring you an amazing Palworld server experience!
              </p>
              <div className="estimated-launch">
                <Calendar size={20} />
                <span>Estimated Launch: {communityData.palworld.estimatedLaunch}</span>
              </div>
              <p className="coming-soon-cta">
                Join our Discord to stay updated on the launch!
              </p>
              <a href={communityData.discordInvite} target="_blank" rel="noopener noreferrer">
                <Button className="btn-primary">
                  <Users className="btn-icon" />
                  Join Discord for Updates
                </Button>
              </a>
            </div>
          </Card>
        </div>
      </section>

      {/* Footer */}
      <footer className="footer">
        <div className="footer-container">
          <div className="footer-content">
            <div className="footer-brand">
              <h3>{communityData.name}</h3>
              <p>Building communities, one block at a time.</p>
            </div>
            <div className="footer-links">
              <h4>Quick Links</h4>
              <button onClick={() => scrollToSection('minecraft')} className="footer-link">
                Minecraft
              </button>
              <button onClick={() => scrollToSection('ark')} className="footer-link">
                Ark Survival Ascended
              </button>
              <button onClick={() => scrollToSection('palworld')} className="footer-link">
                Palworld
              </button>
            </div>
            <div className="footer-community">
              <h4>Community</h4>
              <a href={socialLinks.discord} className="footer-link" target="_blank" rel="noopener noreferrer">
                Discord Server
              </a>
            </div>
          </div>
          <div className="footer-bottom">
            <p>&copy; 2025 {communityData.name}. All rights reserved.</p>
          </div>
        </div>
      </footer>
    </div>
  );
};

export default LandingPage;
