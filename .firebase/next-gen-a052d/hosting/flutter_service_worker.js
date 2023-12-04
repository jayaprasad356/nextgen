'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "8b86b2cd37925253fd6ea11fe1218a2e",
"assets/AssetManifest.bin.json": "d71ff42a9ed81cda871b1265f7c1613d",
"assets/AssetManifest.json": "f1630981681613b81d83fc42a5c3e683",
"assets/assets/fonts/Montserrat-Black.ttf": "9c1278c56276b018109f295c1a751a69",
"assets/assets/fonts/Montserrat-BlackItalic.ttf": "a943ff860cf7bda5ce3722cad5c1dc06",
"assets/assets/fonts/Montserrat-Bold.ttf": "1f023b349af1d79a72740f4cc881a310",
"assets/assets/fonts/Montserrat-BoldItalic.ttf": "9d216a715551da3b92a4a9b0e8994868",
"assets/assets/fonts/Montserrat-ExtraBold.ttf": "bd8fb30c6473177cfb9a5544c9ad8fdb",
"assets/assets/fonts/Montserrat-ExtraBoldItalic.ttf": "e07b3f35e3e0073b2cde4c5a951cc24e",
"assets/assets/fonts/Montserrat-ExtraLight.ttf": "fca7947b08333e5ffcb80c069755b5c9",
"assets/assets/fonts/Montserrat-ExtraLightItalic.ttf": "e4d0c1f4d67a7f3d23a1f2f78d24ea57",
"assets/assets/fonts/Montserrat-Italic.ttf": "761177c558bb3a0084aa85704315b990",
"assets/assets/fonts/Montserrat-Light.ttf": "e65ae7ed560da1a63db603bd8584cfdb",
"assets/assets/fonts/Montserrat-LightItalic.ttf": "e70e5d8d5129f35418fe2cfaa6132c1d",
"assets/assets/fonts/Montserrat-Medium.ttf": "b3ba703c591edd4aad57f8f4561a287b",
"assets/assets/fonts/Montserrat-MediumItalic.ttf": "2e7c02a0a4a5fd318b0625d120ad2033",
"assets/assets/fonts/Montserrat-Regular.ttf": "3fe868a1a9930b59d94d2c1d79461e3c",
"assets/assets/fonts/Montserrat-SemiBold.ttf": "fb428a00b04d4e93deb4d7180814848b",
"assets/assets/fonts/Montserrat-SemiBoldItalic.ttf": "d41c0a341637c2e35ae019730b2d45a5",
"assets/assets/fonts/Montserrat-Thin.ttf": "4b73d125bab54f94ed2510590c237f73",
"assets/assets/fonts/Montserrat-ThinItalic.ttf": "59cdce8fbd384a39ab0fd14b9f693de5",
"assets/assets/icon/Minus%2520regtangle.png": "bea037700e680fad69ed81ba66568165",
"assets/assets/icon/Pluse%2520regtangle.png": "0aa45299ab34f081320acc305a1bc093",
"assets/assets/images/6941697-removebg-preview.png": "d5aa882027d8aebea34644e32fd1f380",
"assets/assets/images/Add.jpg": "00519a419d7ef2ca1031d4766169b3cf",
"assets/assets/images/add.png": "6a751c32ca4537d5c926428960aaeb82",
"assets/assets/images/add2.png": "9b91bcd01daa94a1d4a113d7d1c6a99c",
"assets/assets/images/ads.jpg": "5da5909255379828448b4e6beea68ed0",
"assets/assets/images/ADS_icon.png": "287fb9ce1a79edc77508ceda1bafa34f",
"assets/assets/images/Ads_my_offer.jpg": "0647dde4291416740ac75ea442e7bc70",
"assets/assets/images/applogo.jpeg": "26eeb835513557fac6a3bd36d62c45c8",
"assets/assets/images/bin.png": "3f50961f96a77a8c4ac2df1fccb8a6e7",
"assets/assets/images/btnbg.png": "01179f2f0c998c76528699ff2642747d",
"assets/assets/images/challenge.png": "d0353c7a54a06f7092be59622c089d39",
"assets/assets/images/coin.png": "0caf78a93ab791d2fb57664ea651ab5f",
"assets/assets/images/copy.png": "a905722cb244de3d0389f9fbaaefcd71",
"assets/assets/images/cosmetics-or-skin-care-product-ads-with-bottle-banner-ad-for-beauty-products-and-leaf-background-glittering-light-effect-design-vector.jpg": "361b8b523e49c88b3aeb0eac86726ad6",
"assets/assets/images/download-removebg-preview.png": "9211a14d5678e8723e873481821b1b9b",
"assets/assets/images/fly.png": "90a049e0ba56f9e7f2d7aafb017ce975",
"assets/assets/images/Group%25201959.png": "5d12284bbd205366462218f5ca6c81ce",
"assets/assets/images/Group%25201960.png": "ad7d27e3b0095554c2e822c18f5e77aa",
"assets/assets/images/Group%25201961.png": "eef3daf2e6c722786814d5bc59c6a625",
"assets/assets/images/Group%25201963.png": "0b6eea35580c8db2d02607042c3b1670",
"assets/assets/images/Group%25201964.png": "33c24ee2cf23220114b5f7714a5182fd",
"assets/assets/images/Group%25201966.png": "3254782b7e026cf5f744200231af250b",
"assets/assets/images/Group%25201967.png": "c8d1577ce237e819a01f2418918754e1",
"assets/assets/images/Group%25202.png": "da25b4e24584f8b68f0870f0819e29dc",
"assets/assets/images/help.png": "69f93bd0f154c314fac4e045c636b067",
"assets/assets/images/home.png": "0fd7615404b3c6ca12b3c922db42f410",
"assets/assets/images/images%2520(10)%25201.png": "83586d57265f9aed167cf6965fb922af",
"assets/assets/images/info.png": "231ac9c745cec4c46a047db910c090d8",
"assets/assets/images/job_detail_1.png": "a7b0d792932f026841ee99e2e8035ed0",
"assets/assets/images/job_detail_2.png": "8046163eabeac3f6dac538a52bb47c83",
"assets/assets/images/job_detail_3.png": "4ebbebdff72fcc5438b9bfaf446f325f",
"assets/assets/images/job_detail_4.png": "c7a23024a408cc0f7fd25c1e7ec7a798",
"assets/assets/images/job_detail_5.png": "30f949efb202054ab80e8b7afad4be9b",
"assets/assets/images/job_detail_6.png": "6a8a8c64b1369f34e0012a52ef168ad2",
"assets/assets/images/job_detail_7.png": "5f4fe750852829681c0f87e8f872b978",
"assets/assets/images/job_detail_8.png": "3ec711b8bf4fdb3948cbeb5f8f062df2",
"assets/assets/images/logout.png": "d6365f225c3f96b419e1790c9ffcf186",
"assets/assets/images/main_balance_btn.png": "c6dbf6ac5c239bc95f5318509e4ac7d2",
"assets/assets/images/money.png": "4c830314632956a12ac28323c9de84fd",
"assets/assets/images/NextGen%2520Job%2520Details%2520-%25201.jpg": "267a59018dd16010899d44e457da8eb8",
"assets/assets/images/NextGen%2520Job%2520Details%2520-%252010.jpg": "537208b7105dbea798913cdd9d6ce249",
"assets/assets/images/NextGen%2520Job%2520Details%2520-%252011.jpg": "cc5fdd2e824a09e3b3313e2223f0a6c4",
"assets/assets/images/NextGen%2520Job%2520Details%2520-%25202.jpg": "b0f6ff1b0f325b475d25b3f786acb658",
"assets/assets/images/NextGen%2520Job%2520Details%2520-%25203.jpg": "f76f01dd3202b8ba5ded5ea1443737ca",
"assets/assets/images/NextGen%2520Job%2520Details%2520-%25204.jpg": "4f238bc7dd028b669e7b6904cfc302ec",
"assets/assets/images/NextGen%2520Job%2520Details%2520-%25205.jpg": "acd008e69f751e8ef9e5dd4313f26032",
"assets/assets/images/NextGen%2520Job%2520Details%2520-%25206.jpg": "5a7849560fb1b49fae7a64aa6472d4c5",
"assets/assets/images/NextGen%2520Job%2520Details%2520-%25207.jpg": "b4fba15ed85eb30d532386e1fb7ac144",
"assets/assets/images/NextGen%2520Job%2520Details%2520-%25208.jpg": "5ea2f444d949c05c5205abe42ba57ae2",
"assets/assets/images/NextGen%2520Job%2520Details%2520-%25209.jpg": "6df4c825632febdc38d5eb25d474e919",
"assets/assets/images/notification.png": "569782bf061d9de98c2eb5f72ac29d93",
"assets/assets/images/otp_mobile.png": "01030f85f3bd49f0a772adccf3f443ff",
"assets/assets/images/poster.jpg": "9ccffd6897c8f142c6540b1a7fe07a1b",
"assets/assets/images/profile.png": "a30b47c6ce93f09b473a24c7d046bfe8",
"assets/assets/images/result.png": "025e013d71a37d7cf03b004050e714a5",
"assets/assets/images/side_bg.png": "26315fe45b47e64d5f043474def5ebb3",
"assets/assets/images/splash.png": "4efc5e9e346d2e11175a0837c639a5ce",
"assets/assets/images/success.png": "c6a4e3d5830056de5458610893de2171",
"assets/assets/images/Wallet.png": "00be1c42b739e103652e43754f5e4eea",
"assets/assets/images/WhatsApp%2520Image%25202023-12-02%2520at%25207.46.52%2520PM.jpeg": "a2732b4e8fd030ad968f7a32422b9770",
"assets/FontManifest.json": "8f681fb730bd112329d361dc14515d1a",
"assets/fonts/MaterialIcons-Regular.otf": "4d2d68738f5ea1b560001287deda8262",
"assets/NOTICES": "f2438da79324ffa403ccf0bfcfced174",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "89ed8f4e49bcdfc0b5bfc9b24591e347",
"assets/packages/fluttertoast/assets/toastify.css": "a85675050054f179444bc5ad70ffc635",
"assets/packages/fluttertoast/assets/toastify.js": "56e2c9cedd97f10e7e5f1cebd85d53e3",
"assets/packages/flutter_inappwebview/assets/t_rex_runner/t-rex.css": "5a8d0222407e388155d7d1395a75d5b9",
"assets/packages/flutter_inappwebview/assets/t_rex_runner/t-rex.html": "16911fcc170c8af1c5457940bd0bf055",
"assets/packages/progress_dialog_null_safe/assets/double_ring_loading_io.gif": "a03b96c4f7bef9fd9ed90eb516267a11",
"assets/packages/youtube_player_flutter/assets/speedometer.webp": "50448630e948b5b3998ae5a5d112622b",
"assets/shaders/ink_sparkle.frag": "4096b5150bac93c41cbc9b45276bd90f",
"canvaskit/canvaskit.js": "eb8797020acdbdf96a12fb0405582c1b",
"canvaskit/canvaskit.wasm": "64edb91684bdb3b879812ba2e48dd487",
"canvaskit/chromium/canvaskit.js": "0ae8bbcc58155679458a0f7a00f66873",
"canvaskit/chromium/canvaskit.wasm": "f87e541501c96012c252942b6b75d1ea",
"canvaskit/skwasm.js": "87063acf45c5e1ab9565dcf06b0c18b8",
"canvaskit/skwasm.wasm": "4124c42a73efa7eb886d3400a1ed7a06",
"canvaskit/skwasm.worker.js": "bfb704a6c714a75da9ef320991e88b03",
"favicon.png": "cd7abdc5aeabd212ef1bf321947957b7",
"firebase-debug.log": "278cef1aab9179b5ca71ae0fe2a40cc4",
"flutter.js": "59a12ab9d00ae8f8096fffc417b6e84f",
"icons/Icon-192.png": "e8c27a89dd412da981b4274eb2e410f8",
"icons/Icon-512.png": "fc3e8f58422483e16b09668080491a9a",
"icons/Icon-maskable-192.png": "e8c27a89dd412da981b4274eb2e410f8",
"icons/Icon-maskable-512.png": "fc3e8f58422483e16b09668080491a9a",
"index.html": "870b2f63792dbf4c3156199c9b78ad4a",
"/": "870b2f63792dbf4c3156199c9b78ad4a",
"main.dart.js": "f656c34dfe5a922f4b51dc301b65eb12",
"manifest.json": "8a19cc47611d5da2398d9b6f03b6b43b",
"splash/img/dark-1x.png": "7dc17cd5d0ef5a23e36e3563e55e1828",
"splash/img/dark-2x.png": "fe3f43722247d04ca8cb0f0137919dde",
"splash/img/dark-3x.png": "f73c0ad4a710ec03f92a4aacbf781388",
"splash/img/dark-4x.png": "d5f8ea6c5648c573b2512cbe83f41144",
"splash/img/light-1x.png": "7dc17cd5d0ef5a23e36e3563e55e1828",
"splash/img/light-2x.png": "fe3f43722247d04ca8cb0f0137919dde",
"splash/img/light-3x.png": "f73c0ad4a710ec03f92a4aacbf781388",
"splash/img/light-4x.png": "d5f8ea6c5648c573b2512cbe83f41144",
"splash/splash.js": "d6c41ac4d1fdd6c1bbe210f325a84ad4",
"splash/style.css": "66b4f492954a35a3e8ab906c1bbc7904",
"version.json": "7e601c252e994a3e078e733243d93bc2"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"assets/AssetManifest.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
