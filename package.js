Package.describe({
  name: "mizzao:animated-each",
  summary: "Visual animations for dynamic data",
  version: "0.2.0",
  git: "https://github.com/mizzao/meteor-animated-each.git"
});

Package.onUse(function (api) {
  api.versionsFrom("1.0");

  api.use('jquery', 'client');
  api.use('coffeescript', 'client');

  api.use("mizzao:build-fetcher@0.2.0");

  // Must be loaded after jQuery, see
  // https://github.com/rstacruz/jquery.transit
  api.addFiles('jquery.transit.fetch.json', 'client');
  api.addFiles('animation.coffee', 'client');

  api.export(['AnimatedEach'], 'client');
});
