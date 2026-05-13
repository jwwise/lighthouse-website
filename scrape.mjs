import scrape from 'website-scraper';
import path from 'path';
import { fileURLToPath } from 'url';

const __dirname = path.dirname(fileURLToPath(import.meta.url));

const options = {
  urls: ['https://lbcpayette.net'],
  directory: path.join(__dirname, 'site-mirror'),
  recursive: true,
  maxRecursiveDepth: 3,
  prettifyUrls: true,
  request: {
    headers: {
      'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36'
    }
  },
  sources: [
    { selector: 'a', attr: 'href' },
    { selector: 'img', attr: 'src' },
    { selector: 'img', attr: 'srcset' },
    { selector: 'link[rel="stylesheet"]', attr: 'href' },
    { selector: 'script', attr: 'src' },
    { selector: 'source', attr: 'src' },
    { selector: 'source', attr: 'srcset' },
    { selector: 'meta[name="og:image"]', attr: 'content' },
  ],
  urlFilter: (url) => url.startsWith('https://lbcpayette.net') || url.startsWith('http://lbcpayette.net'),
};

console.log('Starting site mirror of https://lbcpayette.net ...');
console.log('Output: site-mirror/');

try {
  const result = await scrape(options);
  console.log(`\nDone. Downloaded ${result.length} resources.`);
} catch (err) {
  console.error('Error:', err.message);
  process.exit(1);
}
