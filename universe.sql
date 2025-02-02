-- Create database
CREATE DATABASE universe;

-- Switch to the universe database (run manually if using PostgreSQL)
-- \c universe;

-- Create galaxy table
CREATE TABLE galaxy (
    galaxy_id SERIAL PRIMARY KEY,
    name VARCHAR(255) UNIQUE NOT NULL,
    size_in_lightyears NUMERIC NOT NULL,
    has_black_hole BOOLEAN NOT NULL,
    galaxy_type TEXT
);

-- Create star table
CREATE TABLE star (
    star_id SERIAL PRIMARY KEY,
    name VARCHAR(255) UNIQUE NOT NULL,
    galaxy_id INT REFERENCES galaxy(galaxy_id) ON DELETE CASCADE,
    star_type TEXT NOT NULL,
    luminosity NUMERIC
);

-- Create planet table
CREATE TABLE planet (
    planet_id SERIAL PRIMARY KEY,
    name VARCHAR(255) UNIQUE NOT NULL,
    star_id INT REFERENCES star(star_id) ON DELETE CASCADE,
    radius_km INT NOT NULL,
    has_life BOOLEAN NOT NULL,
    orbital_period_days INT
);

-- Create moon table
CREATE TABLE moon (
    moon_id SERIAL PRIMARY KEY,
    name VARCHAR(255) UNIQUE NOT NULL,
    planet_id INT REFERENCES planet(planet_id) ON DELETE CASCADE,
    geology TEXT NOT NULL,
    has_water BOOLEAN
);

-- Create asteroid table
CREATE TABLE asteroid (
    asteroid_id SERIAL PRIMARY KEY,
    name VARCHAR(255) UNIQUE NOT NULL,
    size_km NUMERIC NOT NULL,
    is_near_earth BOOLEAN NOT NULL,
    asteroid_type TEXT
);

-- Insert Galaxies
INSERT INTO galaxy (name, size_in_lightyears, has_black_hole, galaxy_type) VALUES
('Milky Way', 100000, TRUE, 'Spiral'),
('Andromeda', 220000, TRUE, 'Spiral'),
('Triangulum', 60000, FALSE, 'Spiral'),
('Whirlpool', 76000, TRUE, 'Spiral'),
('Sombrero', 50000, TRUE, 'Spiral'),
('Large Magellanic Cloud', 14000, FALSE, 'Irregular'),
('Messier 87', 980000, TRUE, 'Elliptical');

-- Insert Stars
INSERT INTO star (name, galaxy_id, star_type, luminosity) VALUES
('Sun', 1, 'G-type main-sequence', 1.0),
('Sirius', 1, 'A-type main-sequence', 25.4),
('Vega', 1, 'A-type main-sequence', 40.12),
('Betelgeuse', 1, 'Red supergiant', 126000),
('Alpha Centauri A', 1, 'G-type main-sequence', 1.5),
('Alpha Centauri B', 1, 'K-type main-sequence', 0.5);

-- Insert Planets
INSERT INTO planet (name, star_id, radius_km, has_life, orbital_period_days) VALUES
('Earth', 1, 6371, TRUE, 365),
('Mars', 1, 3389, FALSE, 687),
('Jupiter', 1, 69911, FALSE, 4333),
('Saturn', 1, 58232, FALSE, 10759),
('Neptune', 1, 24622, FALSE, 60190),
('Uranus', 1, 25362, FALSE, 30660),
('Proxima b', 6, 7150, FALSE, 11.2),
('Kepler-442b', 3, 5100, FALSE, 112.3),
('HD 209458 b', 2, 94000, FALSE, 3.5),
('Gliese 581c', 5, 8200, FALSE, 13.0),
('Kepler-22b', 4, 24000, FALSE, 290.0),
('TRAPPIST-1e', 3, 5816, FALSE, 12.3);

-- Insert Moons with Geology
INSERT INTO moon (name, planet_id, geology, has_water) VALUES
('Moon', 1, 'Rocky, basaltic plains and highlands', TRUE),
('Phobos', 2, 'Heavily cratered, dusty regolith', FALSE),
('Deimos', 2, 'Smooth dusty surface with loose regolith', FALSE),
('Io', 3, 'Volcanic activity, sulfur-rich plains', FALSE),
('Europa', 3, 'Icy crust with subsurface ocean', TRUE),
('Ganymede', 3, 'Largest moon, icy surface with grooves', TRUE),
('Callisto', 3, 'Heavily cratered ice and rock surface', FALSE),
('Titan', 4, 'Thick nitrogen atmosphere, liquid methane lakes', TRUE),
('Enceladus', 4, 'Icy surface, cryovolcanism, water plumes', TRUE),
('Triton', 5, 'Retrograde orbit, icy surface with nitrogen geysers', TRUE),
('Miranda', 6, 'Tectonic ridges and cliffs, mixed icy terrain', FALSE),
('Ariel', 6, 'Canyon-like rifts, relatively young surface', FALSE),
('Umbriel', 6, 'Dark, heavily cratered icy surface', FALSE),
('Titania', 6, 'Icy crust with fault valleys', FALSE),
('Oberon', 6, 'Cratered, ancient icy surface', FALSE),
('Charon', 5, 'Water ice and ammonia hydrates on surface', TRUE),
('Nix', 5, 'Small icy body with reddish hue', FALSE),
('Hydra', 5, 'Irregularly shaped, icy surface', FALSE),
('Kerberos', 5, 'Dark and irregular, possibly water ice', FALSE),
('Styx', 5, 'Bright surface, likely water ice', FALSE);

-- Insert Asteroids
INSERT INTO asteroid (name, size_km, is_near_earth, asteroid_type) VALUES
('Ceres', 945, FALSE, 'Dwarf planet'),
('Vesta', 525, FALSE, 'Main belt asteroid'),
('Eros', 34, TRUE, 'Near-Earth asteroid'),
('Pallas', 512, FALSE, 'Main belt asteroid'),
('Apophis', 0.37, TRUE, 'Potentially hazardous asteroid');
