# Emergency Dental of America (EDOA) — Unified Website Platform

A unified WordPress and KadenceWP child theme platform consolidating 23 city-specific dental websites under a single domain: **emergencydentalofamerica.com**.

## 📋 Overview

This project consolidates location-specific dental websites (e.g., `emergencydentaloflasvegas.com`) into a scalable, maintainable WordPress architecture using:

- **WordPress 6.x** — Core CMS
- **KadenceWP** — Parent theme with global design system
- **Custom KadenceWP Child Theme** — EDOA-specific branding and location pages
- **Advanced Custom Fields (ACF)** — Dynamic location data management
- **Custom Post Types (CPT)** — Location-based content structure
- **PHP 7.4+** — Backend logic and templating

### Key Features

✅ Scalable location page architecture (`/locations/{city-slug}/`)  
✅ Reusable templates for 23+ locations  
✅ KadenceWP Global Palette CSS variables for brand consistency  
✅ SEO-optimized local business schema markup  
✅ Compassionate, action-oriented copywriting and CTAs  
✅ Accessible semantic HTML5 with ARIA support  
✅ Performance-optimized with lazy loading and caching strategies  

---

## 🚀 Quick Start

### Prerequisites

- **PHP 7.4+** (or via devcontainer)
- **MySQL 5.7+** or **MariaDB 10.3+**
- **Git**
- **Composer** (optional, for dependency management)

### Installation

#### 1. Clone the Repository

```bash
git clone https://github.com/ricknogerscreative/cms-codespace.git
cd cms-codespace
```

#### 2. Install WordPress Core

```bash
bash install-wordpress.sh .
```

This downloads and extracts the latest WordPress core into the workspace.

#### 3. Create Database & User

```bash
bash create-wp-db.sh
```

Follow the prompts to create the WordPress database. Default values:
- Database: `edoa_wp`
- User: `edoa_user`
- Password: Prompted securely

Alternatively, override with environment variables:
```bash
DB_NAME=my_db DB_USER=my_user DB_PASSWORD='MyPass123!' bash create-wp-db.sh
```

#### 4. Configure wp-config.php

Edit `wp-config.php` and update:
```php
define( 'DB_NAME', 'edoa_wp' );
define( 'DB_USER', 'edoa_user' );
define( 'DB_PASSWORD', 'your_password_here' );
define( 'DB_HOST', 'localhost' );
```

Optionally, update authentication keys from [WordPress.org Secret Key Service](https://api.wordpress.org/secret-key/1.1/salt/).

#### 5. Start Development Server (if using devcontainer)

```bash
# Via VS Code Remote Containers
# Press Ctrl+Shift+P > Remote-Containers: Reopen in Container
```

Or manually with PHP:
```bash
php -S localhost:8000
```

Then open http://localhost:8000 in your browser and complete the WordPress installation wizard.

---

## 📁 Project Structure

```
cms-codespace/
├── .devcontainer/          # VS Code dev container setup
├── .github/
│   └── agents/             # Custom AI agent configs (junior-wordpress-developer)
├── wp-admin/               # WordPress admin (core)
├── wp-includes/            # WordPress core includes
├── wp-content/
│   ├── plugins/            # Third-party plugins (not tracked)
│   ├── themes/
│   │   └── edoa-kadence-child/  # ✅ EDOA custom child theme (tracked)
│   └── uploads/            # User media (not tracked)
├── wp-*.php                # WordPress core files
├── wp-config.php           # Database configuration (not tracked)
├── wp-config-sample.php    # Template for wp-config.php
│
├── install-wordpress.sh    # Download & extract WordPress core
├── create-wp-db.sh         # Create database and user
├── .gitignore              # Git ignore rules
└── README.md               # This file
```

---

## 🎨 Theme Development

### KadenceWP Child Theme Location

Create or develop the child theme at:
```
wp-content/themes/edoa-kadence-child/
```

### Child Theme Structure

```
edoa-kadence-child/
├── functions.php           # PHP hooks & customizations
├── style.css              # Child theme styles
├── template-parts/        # Reusable template components
├── single-location.php    # Single location template
├── archive-location.php   # Location archive/list template
└── screenshot.png         # Theme preview image
```

### Best Practices

1. **Never modify the Kadence parent theme** — all customizations go in the child theme.
2. **Use hooks over hardcoding** — `add_action()`, `add_filter()`, `remove_action()`.
3. **Register assets properly** — use `wp_enqueue_scripts` for CSS/JS.
4. **Use Kadence's CSS variables** — reference `--global-palette1` through `--global-palette9`.
5. **Leverage Kadence blocks** — reuse Kadence Elements for headers, footers, CTAs.
6. **Write semantic HTML5** — proper heading hierarchy, ARIA labels, alt text.
7. **Document your code** — add comments explaining custom logic.

### Example: Registering a Custom Stylesheet

```php
// In functions.php
add_action( 'wp_enqueue_scripts', function() {
    wp_enqueue_style(
        'edoa-custom',
        get_stylesheet_directory_uri() . '/style.css',
        array( 'kadence-theme' ),
        wp_get_theme()->get( 'Version' )
    );
});
```

---

## 📍 Location Page Architecture

### Custom Post Type: Location

Location data is managed via a Custom Post Type (CPT) with fields in ACF:

| Field | Type | Purpose |
|-------|------|---------|
| `location_name` | Text | City/location name (e.g., "Las Vegas") |
| `location_slug` | Text | URL slug (e.g., "las-vegas") |
| `address` | Text | Street address |
| `phone` | Text | Phone number (CallRail tracked) |
| `hours` | Repeater | Opening/closing times by day |
| `services` | Checkboxes | Services offered (emergency, extraction, etc.) |
| `reviews` | Relationship | Link to patient reviews |

### Single Location Template

Create `single-location.php` to display individual location pages:

```php
<?php
/**
 * Single Location Template
 * Path: wp-content/themes/edoa-kadence-child/single-location.php
 */

get_header();

while ( have_posts() ) {
    the_post();
    
    $location_name = get_field( 'location_name' );
    $address = get_field( 'address' );
    $phone = get_field( 'phone' );
    $hours = get_field( 'hours' );
    $services = get_field( 'services' );
    ?>
    
    <main id="primary" class="site-main">
        <h1><?php echo esc_html( $location_name ); ?></h1>
        
        <section class="location-info">
            <h2>Location Details</h2>
            <p><strong>Address:</strong> <?php echo esc_html( $address ); ?></p>
            <p><strong>Phone:</strong> <a href="tel:<?php echo esc_attr( $phone ); ?>"><?php echo esc_html( $phone ); ?></a></p>
        </section>
        
        <section class="location-hours">
            <h2>Hours</h2>
            <!-- Loop through hours repeater field -->
        </section>
        
        <section class="location-services">
            <h2>Services Offered</h2>
            <!-- Display services checkboxes -->
        </section>
        
        <section class="cta-booking">
            <a href="#booking-widget" class="btn btn-primary">Book Online – Free</a>
            <a href="tel:<?php echo esc_attr( $phone ); ?>" class="btn btn-secondary">Call Now</a>
        </section>
        
        <section class="reviews">
            <h2>Patient Reviews</h2>
            <!-- Display linked reviews -->
        </section>
    </main>
    
    <?php
}

get_footer();
?>
```

### URL Structure

Location pages are accessible at:
```
emergencydentalofamerica.com/locations/{city-slug}/
```

Examples:
- `/locations/las-vegas/`
- `/locations/san-francisco/`
- `/locations/denver/`

---

## 🎯 Brand Guidelines

### Color Palette

**Primary:** Red (#C0392B)  
**Secondary:** Dark Charcoal (#2C3E50) / Black (#000)  
**Accent:** Light Gray (#ECF0F1) for backgrounds

Use Kadence's Global Palette CSS variables:
```css
.cta-button {
    background-color: var(--global-palette1); /* Primary Red */
    color: var(--global-palette9);             /* Text color */
}
```

### Voice & Tone

- **Calm, compassionate, action-oriented**
- Never fear-based or salesy
- Clear and direct messaging
- Accessibility-first design

### Call-to-Action Examples

✅ "Book Online – Free"  
✅ "Call 1-800-555-1234"  
✅ "Find a Location"  
✅ "Emergency Dental Care Near You"  

---

## 🔍 SEO & Performance

### Local Business Schema

Add schema markup for each location (via `functions.php` or block editor):

```php
$schema = array(
    '@context' => 'https://schema.org',
    '@type' => 'Dentist',
    'name' => get_field( 'location_name' ),
    'address' => get_field( 'address' ),
    'telephone' => get_field( 'phone' ),
);

wp_localize_script( 'edoa-schema', 'locationSchema', $schema );
```

### Canonical URLs

Ensure canonical tags point to the correct unified domain:
```html
<link rel="canonical" href="https://emergencydentalofamerica.com/locations/city-name/" />
```

### Performance Tips

- ✅ Lazy load images: `loading="lazy"` on `<img>` tags
- ✅ Minimize render-blocking CSS/JS
- ✅ Leverage Kadence's caching settings
- ✅ Use a CDN for media assets
- ✅ Minify custom CSS/JS in production

---

## 🛠️ Development Workflow

### Local Setup

1. Install WordPress core and database (see Quick Start above).
2. Activate **Kadence Pro** theme from WordPress admin (if not already active).
3. Create or pull the `edoa-kadence-child` theme into `wp-content/themes/`.
4. Install and activate **Advanced Custom Fields Pro** plugin (or free version).
5. Define custom post types and ACF field groups via code or UI.
6. Start developing templates in the child theme.

### Git Workflow

```bash
# Create feature branch
git checkout -b feature/location-pages

# Make changes to child theme, functions, etc.
# Commit regularly
git add wp-content/themes/edoa-kadence-child/
git commit -m "Add single-location template with schema markup"

# Push and create pull request
git push origin feature/location-pages
```

### Code Standards

- **PHP:** Follow [WordPress Coding Standards](https://developer.wordpress.org/coding-standards/wordpress-coding-standards/)
- **HTML:** Semantic HTML5, proper heading hierarchy, ARIA labels
- **CSS:** Use Kadence variables, BEM naming convention for custom classes
- **Comments:** Document custom functions, hooks, and template logic

---

## 🚢 Deployment

### Pre-Deployment Checklist

- [ ] All custom code tested locally
- [ ] Child theme properly inherits from Kadence
- [ ] ACF field definitions exported/documented
- [ ] Canonical URLs configured
- [ ] Schema markup validated via [Schema.org validator](https://validator.schema.org/)
- [ ] All 23 locations have CPT entries with complete data
- [ ] Performance tested (Core Web Vitals)
- [ ] Security audit (wp-config, permissions, plugin updates)

### Database Migration

To move from development to production:

```bash
# Export production database (from old city sites or backup)
mysqldump -u root -p old_db > production_backup.sql

# Import to new unified database
mysql -u edoa_user -p edoa_wp < production_backup.sql
```

### Environment Variables

Use `.env` file (not tracked in git) for environment-specific config:

```bash
# .env (local development)
DB_NAME=edoa_wp
DB_USER=edoa_user
DB_PASSWORD=dev_password
WP_ENV=development
```

Load via `wp-config.php`:
```php
if ( file_exists( __DIR__ . '/.env' ) ) {
    require __DIR__ . '/.env';
}
```

---

## 📚 Documentation & Resources

- [WordPress Plugin Developer Handbook](https://developer.wordpress.org/plugins/)
- [WordPress Theme Developer Handbook](https://developer.wordpress.org/themes/)
- [Kadence Theme Documentation](https://www.kadencewp.com/docs/)
- [Advanced Custom Fields Documentation](https://www.advancedcustomfields.com/resources/)
- [WordPress Coding Standards](https://developer.wordpress.org/coding-standards/)

---

## 🤝 Contributing

### For Team Members

1. **Branch naming:** `feature/`, `bugfix/`, `docs/` prefixes
2. **Commit messages:** Clear, descriptive, reference issue/ticket numbers
3. **Pull requests:** Include description, testing notes, screenshots (if applicable)
4. **Code review:** Minimum 1 approval before merging to `main`

### Code Review Checklist

- [ ] Code follows WordPress standards
- [ ] Child theme not modified
- [ ] No sensitive data (passwords, API keys) committed
- [ ] Proper use of hooks and filters
- [ ] HTML is semantic and accessible
- [ ] Tested in multiple browsers
- [ ] Performance impact considered

---

## 🐛 Troubleshooting

### MySQL Connection Error (ERROR 2002)

```bash
sudo systemctl start mysql
sudo systemctl status mysql
```

### WordPress White Screen of Death (WSOD)

Enable debugging in `wp-config.php`:
```php
define( 'WP_DEBUG', true );
define( 'WP_DEBUG_LOG', true );
define( 'WP_DEBUG_DISPLAY', false );
```

Check logs at `wp-content/debug.log`.

### Permission Issues

```bash
chmod -R 755 wp-content/themes/edoa-kadence-child/
chmod -R 755 wp-content/plugins/
chmod 644 wp-config.php
```

---

## 📞 Support & Contact

For questions or issues:

- **Project Lead:** [Contact info]
- **Tech Issues:** Open an issue on GitHub
- **Emergency:** Contact on-call developer

---

## 📄 License

This project includes WordPress core (GPL-2.0) and custom code under [license to be determined].

For third-party theme/plugin licenses, refer to individual package documentation.

---

**Last Updated:** May 2026  
**Version:** 1.0.0 (Initial Setup)
