meteor-animated-each
====================

This Meteor package makes it easier for many users to interact with highly dynamic data by preserving context and showing visual cues as data changes. It currently does the following:

  - Adjust scrolling position to keep current viewport items visible as other items are added or removed.
  - Animate insertions and removals to provide visual cues for changing data.

These features are easily explained with the demo at http://animated-each.meteor.com. (See the [source](demo)). Play with the demo in multiple browsers to see how it works.

## Usage

Install the package:

```
mrt add animated-each
```

#### `AnimatedEach.attachHooks(container, scrollParent)`

Enable the features of this package on `container` using Meteor's [UI hooks](https://groups.google.com/forum/#!msg/meteor-core/1kUoG2mcaRw/U-lIzmYEAQ0J). The `container` should be a DOM node that is the direct parent of an `{{#each}}` helper. For example:

```
<template name="foo">
    <div class="bar">
        {{#each data}}
        {{> someTemplate }}
        {{/each}}
    </div>
</template>
```

You can activate the animations with the following:

```
Template.foo.rendered = function() {
    AnimateEach.attachHooks( this.find(".bar") );
};
```

The second argument `scrollParent` should be a selector for the element that this content scrolls within. If you are using jQuery UI (such as with the [meteor-jqueryui](https://github.com/mizzao/meteor-jqueryui) package), the scroll parent will be computed automatically and you can omit this argument.
