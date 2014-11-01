class AnimatedEach

  _getScrollParent = (scrollParent, node) ->
    return $(scrollParent) if scrollParent?
    return $(node).scrollParent() if jQuery.fn.scrollParent?
    Meteor._debug("Could not find scroll parent; assuming body for ", node)
    return $("body")

  ###
    container: the node that will contain the #each elements as children
    scrollParent: (optional) the element that this container scrolls within
  ###
  @attachHooks: (container, scrollParent) ->
    # See reference implementation at packages/ui/domrange.js
    container._uihooks =
      insertElement: (node, next) ->
        # Make the node invisible before fading in
        $(node).css("opacity", 0)
        container.insertBefore(node, next)

        $(node).transition {opacity: 1}, "slow", "in", ->
          $(this).css("opacity", "")

        $sp = _getScrollParent(scrollParent, node)
        spOffset = $sp.offset()

        # Compute whether we should adjust scroll position as node fades in.
        # This is computed from the top of the node, approximating the
        # insertion position
        nodeOffset = $(node).offset()
        nodeHeight = $(node).outerHeight(true)

        # If node was inserted above the midpoint of the viewport, scroll
        # down by that amount
        if (nodeOffset.top) < (spOffset.top + $sp.height()/2)
          $sp[0].scrollTop += nodeHeight

      moveElement: (node, next) ->
        # TODO: we can animate this too!
        container.insertBefore(node, next)

      removeElement: (node) ->
        # We need to compute these before the fadeOut, or the height will be
        # incorrect. Moreover, it is logically correct to compare the position
        # of the node before any scrolling to the position of the viewport after
        # any scrolling that happens during the fade (right?)
        nodeOffset = $(node).offset()
        # The space we need to adjust - including top and bottom margins, if
        # applicable
        nodeHeight = $(node).outerHeight(true)

        $sp = _getScrollParent(scrollParent, node)
        spOffset = $sp.offset()

        # Fade out the node, and when completed remove it and adjust the
        # scroll height
        $(node).transition {opacity: 0}, "slow", "out", ->
          $(this).remove() # equiv to parent.removeChild(node) or $node.remove()

          # Adjust scroll position around the removed element, if it was above
          # the viewport
          if (nodeOffset.top + nodeHeight/2) < (spOffset.top + $sp.height()/2)
            $sp[0].scrollTop -= nodeHeight
        return
