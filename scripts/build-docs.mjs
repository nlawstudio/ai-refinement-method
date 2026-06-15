#!/usr/bin/env node
/*
 * build-docs.mjs — render the styled decks to self-contained HTML.
 *
 * GitHub and most markdown viewers strip <style> blocks, so the decks never
 * show their theme there. This wraps each markdown deck in an HTML shell with
 * theme/theme.css inlined and Mermaid rendered client-side, producing files you
 * can open in a browser and print to PDF.
 *
 * Usage:  node scripts/build-docs.mjs            (builds METHOD + QUICKSTART)
 *         node scripts/build-docs.mjs FILE.md    (builds one file)
 *
 * No dependencies — pure Node stdlib. markdown-it and mermaid load from CDN in
 * the output page, so opening the built HTML needs a network connection once.
 */

import { readFileSync, writeFileSync, mkdirSync } from 'node:fs';
import { dirname, basename, join } from 'node:path';
import { fileURLToPath } from 'node:url';

const root = join(dirname(fileURLToPath(import.meta.url)), '..');
const theme = readFileSync(join(root, 'theme', 'theme.css'), 'utf8');

const docs = process.argv.slice(2);
const targets = docs.length ? docs : ['METHOD.md', 'QUICKSTART.md'];

mkdirSync(join(root, 'dist'), { recursive: true });

const page = (title, css, b64) => `<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>${title}</title>
<style>
${css}
</style>
</head>
<body>
<main id="doc"></main>
<script type="text/markdown" id="src">${b64}</script>
<script type="module">
import markdownit from 'https://cdn.jsdelivr.net/npm/markdown-it@14/+esm';
import mermaid from 'https://cdn.jsdelivr.net/npm/mermaid@11/dist/mermaid.esm.min.mjs';

const slug = (s) => s.toLowerCase().trim()
  .replace(/<[^>]+>/g, '')
  .replace(/[^\\w\\s-]/g, '')
  .replace(/\\s+/g, '-');

const md = markdownit({ html: true, linkify: true, breaks: false });

// Render \`\`\`mermaid fences as <pre class="mermaid"> with raw (unescaped) source.
const fence = md.renderer.rules.fence;
md.renderer.rules.fence = (tokens, idx, opts, env, self) => {
  const t = tokens[idx];
  if ((t.info || '').trim() === 'mermaid') return \`<pre class="mermaid">\${t.content}</pre>\`;
  return fence(tokens, idx, opts, env, self);
};

// Give headings GitHub-style ids so the in-page TOC links jump correctly.
md.renderer.rules.heading_open = (tokens, idx, opts, env, self) => {
  const inline = tokens[idx + 1];
  if (inline && inline.type === 'inline') {
    const id = slug(inline.content);
    if (id) tokens[idx].attrSet('id', id);
  }
  return self.renderToken(tokens, idx, opts);
};

const source = decodeURIComponent(escape(atob(document.getElementById('src').textContent)));
document.getElementById('doc').innerHTML = md.render(source);

mermaid.initialize({
  startOnLoad: false,
  theme: 'base',
  themeVariables: {
    fontFamily: 'Inter, system-ui, sans-serif',
    primaryColor: '#F0ECE4',
    primaryTextColor: '#16233D',
    primaryBorderColor: '#16233D',
    lineColor: '#5C6A85',
    secondaryColor: '#F6E2DB',
    tertiaryColor: '#E6EAF1',
    fontSize: '14px'
  }
});
await mermaid.run({ querySelector: '.mermaid' });

// Jump to hash now that headings have ids.
if (location.hash) document.getElementById(location.hash.slice(1))?.scrollIntoView();
</script>
</body>
</html>
`;

// The landing page is hand-authored HTML — copy it in so dist/ is a complete
// deployable site root (index + the styled decks it links to).
writeFileSync(join(root, 'dist', 'index.html'), readFileSync(join(root, 'site', 'index.html')));
console.log('copied dist/index.html  (landing page)');

for (const target of targets) {
  const srcPath = join(root, target);
  let markdown = readFileSync(srcPath, 'utf8');
  // Strip any inline <style> block — theme.css is the single source of truth.
  markdown = markdown.replace(/^\s*<style>[\s\S]*?<\/style>\s*/, '');
  const title = basename(target, '.md');
  // base64 (utf-8 safe) so the markdown can contain any HTML without escaping.
  const b64 = Buffer.from(markdown, 'utf8').toString('base64');
  const out = join(root, 'dist', `${title.toLowerCase()}.html`);
  writeFileSync(out, page(title, theme, b64));
  console.log(`built  dist/${title.toLowerCase()}.html  (${(markdown.length / 1024).toFixed(0)}kb markdown)`);
}
