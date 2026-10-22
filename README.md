# Portfolio — web & mobile projects (2017–2019)

A collection of production projects I built for clients: Laravel e-commerce sites with Voyager CMS, a multilingual information portal, a marketing landing site and an Ionic/Cordova mobile app.

| Project | Period | Stack | Highlights |
|---|---|---|---|
| [Study in Ukraine — admission portal](https://github.com/bandarsiri2026/study-in-ukraine-portal) | Nov 2017 – Sep 2018 | Laravel 5.6, Blade, EN/AR localization | localized routing, university directory, application e-mail workflow |
| [Study in Ukraine — mobile app](https://github.com/bandarsiri2026/study-in-ukraine-app) | late 2017 – early 2018 | Ionic 3, Cordova, Angular 5 | Arabic UI, university catalog, galleries, offline-friendly assets |
| [Svetilo — lighting e-shop](https://github.com/bandarsiri2026/svetilo-lighting-shop) | Jan – Jul 2018 | Laravel 5.5, Voyager, Algolia, shopping cart | catalogue hierarchy, full-text search, order-by-e-mail |
| [Barabashova — hardware shop](https://github.com/bandarsiri2026/barabashova-shop) | Jan – Jun 2018 | Laravel 5.5, Voyager, Algolia | the base codebase later forked into Svetilo |
| [Ekstrasens Valeria — landing site](https://github.com/bandarsiri2026/ekstrasens-valeria-site) | 2019 | Laravel 6.x, hand-written CSS/JS | slider, reviews, contact form, SEO plumbing |
| [Best-Look — clothing magazine](https://github.com/bandarsiri2026/best-look-internet-magazine) | 2017 | Laravel 5.4, Voyager 0.11 | earliest project; evolved into the two shops |

## What each repository contains

- Full source code (dependencies and secrets excluded), README with tech stack, features, structure and setup instructions.
- Schema-only SQL exports (`database/schema.sql`) where a database existed — no customer or order data.
- MIT license for the code; third-party client assets are not licensed for reuse.
- A `v1.0.0` tag marking the published snapshot.

## Notes on the legacy stack

These projects were built with Laravel 5.4–6.x and Voyager 0.11/1.x, all now end-of-life. They are presented as evidence of shipped production work — architecture, data modelling, CMS integration and search wiring — not as current framework best practice.
