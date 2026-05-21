CREATE DATABASE jewelry_store;
USE jewelry_store;

-- =========================
-- USERS TABLE
-- =========================
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    is_admin BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =========================
-- CATEGORIES TABLE
-- =========================
CREATE TABLE categories (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);

-- =========================
-- PRODUCTS TABLE
-- =========================
CREATE TABLE products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    description TEXT,
    price DECIMAL(10,2) NOT NULL,
    stock INT DEFAULT 0,
    image VARCHAR(255),
    category_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_product_category
        FOREIGN KEY (category_id)
        REFERENCES categories(id)
        ON DELETE SET NULL
);

-- =========================
-- CART ITEMS TABLE
-- =========================
CREATE TABLE cart_items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT DEFAULT 1,

    CONSTRAINT fk_cart_user
        FOREIGN KEY (user_id)
        REFERENCES users(id)
        ON DELETE CASCADE,

    CONSTRAINT fk_cart_product
        FOREIGN KEY (product_id)
        REFERENCES products(id)
        ON DELETE CASCADE
);

-- =========================
-- ORDERS TABLE
-- =========================
CREATE TABLE orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    total_price DECIMAL(10,2) NOT NULL,
    status VARCHAR(50) DEFAULT 'Pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_order_user
        FOREIGN KEY (user_id)
        REFERENCES users(id)
        ON DELETE CASCADE
);

-- =========================
-- ORDER ITEMS TABLE
-- =========================
CREATE TABLE order_items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    price DECIMAL(10,2) NOT NULL,

    CONSTRAINT fk_orderitem_order
        FOREIGN KEY (order_id)
        REFERENCES orders(id)
        ON DELETE CASCADE,

    CONSTRAINT fk_orderitem_product
        FOREIGN KEY (product_id)
        REFERENCES products(id)
        ON DELETE CASCADE
);

-- =========================
-- SAMPLE CATEGORIES
-- =========================
INSERT INTO categories (name)
VALUES
('Rings'),
('Necklaces'),
('Bracelets'),
('Earrings'),
('Watches');

-- =========================
-- SAMPLE PRODUCTS
-- =========================
INSERT INTO products
(product_name, description, price, stock_quantity, image_url)
VALUES

('Diamond Ring', 'Luxury diamond ring', 500.00, 10, 'diamond_ring.jpg'),
('Gold Necklace', '24k gold necklace', 750.00, 5, 'gold_necklace.jpg'),
('Silver Bracelet', 'Elegant silver bracelet', 250.00, 15, 'silver_bracelet.jpg'),

('Pearl Earrings', 'Classic pearl earrings', 180.00, 20, 'pearl_earrings.jpg'),
('Ruby Ring', 'Ruby gemstone ring', 620.00, 8, 'ruby_ring.jpg'),
('Emerald Necklace', 'Emerald necklace with gold chain', 890.00, 4, 'emerald_necklace.jpg'),
('Sapphire Bracelet', 'Blue sapphire bracelet', 540.00, 7, 'sapphire_bracelet.jpg'),
('Rose Gold Ring', 'Rose gold engagement ring', 430.00, 11, 'rose_gold_ring.jpg'),
('Heart Pendant', 'Heart-shaped pendant necklace', 210.00, 18, 'heart_pendant.jpg'),
('Crystal Earrings', 'Shiny crystal earrings', 130.00, 25, 'crystal_earrings.jpg'),

('Vintage Ring', 'Vintage style silver ring', 275.00, 12, 'vintage_ring.jpg'),
('Luxury Watch', 'Premium luxury watch', 1200.00, 3, 'luxury_watch.jpg'),
('Charm Bracelet', 'Cute charm bracelet', 160.00, 22, 'charm_bracelet.jpg'),
('Wedding Ring', 'Gold wedding ring', 700.00, 9, 'wedding_ring.jpg'),
('Infinity Necklace', 'Infinity symbol necklace', 240.00, 14, 'infinity_necklace.jpg'),
('Diamond Earrings', 'Sparkling diamond earrings', 950.00, 6, 'diamond_earrings.jpg'),
('Gold Anklet', 'Elegant gold anklet', 190.00, 17, 'gold_anklet.jpg'),
('Silver Chain', 'Pure silver chain necklace', 310.00, 13, 'silver_chain.jpg'),
('Ruby Earrings', 'Ruby gemstone earrings', 420.00, 10, 'ruby_earrings.jpg'),
('Pearl Necklace', 'Luxury pearl necklace', 680.00, 5, 'pearl_necklace.jpg'),

('Crown Ring', 'Crown shaped ring', 350.00, 16, 'crown_ring.jpg'),
('Butterfly Pendant', 'Butterfly pendant necklace', 220.00, 19, 'butterfly_pendant.jpg'),
('Couple Rings', 'Matching couple rings', 480.00, 8, 'couple_rings.jpg'),
('Emerald Earrings', 'Green emerald earrings', 530.00, 7, 'emerald_earrings.jpg'),
('Gold Hoop Earrings', 'Classic gold hoop earrings', 260.00, 20, 'gold_hoop_earrings.jpg'),
('Silver Watch', 'Stylish silver wrist watch', 820.00, 4, 'silver_watch.jpg'),
('Diamond Pendant', 'Diamond pendant necklace', 770.00, 6, 'diamond_pendant.jpg'),
('Luxury Bracelet', 'Luxury gold bracelet', 910.00, 5, 'luxury_bracelet.jpg'),
('Ruby Pendant', 'Ruby heart pendant', 340.00, 11, 'ruby_pendant.jpg'),
('Sapphire Ring', 'Blue sapphire ring', 650.00, 7, 'sapphire_ring.jpg'),

('Flower Necklace', 'Flower shaped necklace', 230.00, 15, 'flower_necklace.jpg'),
('Moon Earrings', 'Moon style earrings', 175.00, 18, 'moon_earrings.jpg'),
('Star Bracelet', 'Star charm bracelet', 210.00, 20, 'star_bracelet.jpg'),
('Luxury Diamond Ring', 'Premium diamond engagement ring', 1500.00, 2, 'luxury_diamond_ring.jpg'),
('Black Pearl Necklace', 'Rare black pearl necklace', 980.00, 3, 'black_pearl_necklace.jpg');
-- SAMPLE ADMIN USER

INSERT INTO users
(username, email, password_hash, is_admin)
VALUES
(
    'admin',
    'admin@store.com',
    'admin123',
    TRUE
);