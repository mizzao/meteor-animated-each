Package.describe({
  summary: "Visual animations for dynamic data"
});

Package.on_use(function (api) {
  api.use('jquery', 'client');
  api.use('coffeescript', 'client');

  api.add_files('animation.coffee', 'client');

  api.export(['AnimatedEach'], 'client');
});
