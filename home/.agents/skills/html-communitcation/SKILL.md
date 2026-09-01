---
name: html-communication
description: Use when the user asks to communicate through an HTML document.
---

# HTML communication

## When to Use

Use this skill when the user wants a plan, spec , write-up, findings, summary, report, comparison, or set of UI mocks presented as readable HTML.

Do **not** use it for HTML that ships as part of a product.

## Document

Create one self-contained HTML file, capped at 512 KB.

- Write it like a spec, not a landing page: dense, scannable, no hero, decorative chrome, marketing voice, or em dashes.
- Default to true black (`#000`), white primary text, and dark gray only for secondary surfaces or accents.
- Make it mobile-readable with a responsive viewport and no fixed-width layout.


## Read a Postplan URL

When a user supplies a `postplan.dev` URL, fetch the uploaded HTML immediately with the shell. Do not use web search or a browser to retrieve it.

1. Remove a trailing slash, then append `/raw` unless the URL already ends in `/raw`.
2. Run `curl --fail --silent --show-error --location --max-time 30 --output /tmp/postplan.html '<raw-url>'`.
3. Read `/tmp/postplan.html` as the user's artifact and continue the requested task.

A web-search refusal is not evidence that Postplan rejected the request. If `curl` fails, report its actual status or network error; do not substitute search results.

## Document Rules
