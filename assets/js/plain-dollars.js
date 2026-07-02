document.addEventListener('DOMContentLoaded', function () {
  var plainDollarAmount = /\$([0-9][0-9,]*(?:\.[0-9]+)?)(?=\s|[.,;:!?)]|$)/;
  var plainDollarAmounts = /\$([0-9][0-9,]*(?:\.[0-9]+)?)(?=\s|[.,;:!?)]|$)/g;
  var walker = document.createTreeWalker(document.body, NodeFilter.SHOW_TEXT, {
    acceptNode: function (node) {
      var parent = node.parentNode;
      if (!parent || /^(SCRIPT|STYLE|TEXTAREA|CODE|PRE)$/i.test(parent.nodeName)) {
        return NodeFilter.FILTER_REJECT;
      }
      return plainDollarAmount.test(node.nodeValue) ? NodeFilter.FILTER_ACCEPT : NodeFilter.FILTER_SKIP;
    }
  });

  var nodes = [];
  while (walker.nextNode()) nodes.push(walker.currentNode);
  nodes.forEach(function (node) {
    node.nodeValue = node.nodeValue.replace(plainDollarAmounts, function (_match, amount) {
      return '\\$' + amount;
    });
  });
});
