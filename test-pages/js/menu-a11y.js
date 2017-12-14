/**
 * Global variables
 */
"use strict";

function focusPopupMenu(event) {
  var node = event.currentTarget.parentNode;
  node.classList.add('focus');
};

function blurPopupMenu(event) {
  var node = event.currentTarget.parentNode;
  node.classList.remove('focus');
};

function focusDropDownMenu(event) {
  var node = event.currentTarget.parentNode.parentNode.parentNode;
  node.classList.add('focus');
};

function blurDropDownMenu(event) {
  var node = event.currentTarget.parentNode.parentNode.parentNode;
  node.classList.remove('focus');
};

window.addEventListener('load', function () {

  var i, node, menuItems, menuItem, dropDownItems, dropDownItem;

  menuItems = document.querySelectorAll('.rd-navbar-nav .rd-navbar-submenu > a');

  for (i = 0; i < menuItems.length; i++) {
    menuItem = menuItems[i];
    menuItem.addEventListener('focus', focusPopupMenu);
    menuItem.addEventListener('blur',  blurPopupMenu);
  }

  dropDownItems = document.querySelectorAll('.rd-navbar-nav .rd-navbar-dropdown a');

  for (i = 0; i < dropDownItems.length; i++) {
    dropDownItem = dropDownItems[i];
    dropDownItem.addEventListener('focus', focusDropDownMenu);
    dropDownItem.addEventListener('blur',  blurDropDownMenu);
  }

  // Adding an accessible name to top of page link

  node = document.getElementById('ui-to-top');

  if (node) {
    node.setAttribute('aria-label', 'Got to top of page');
  }

  var submenuToggles = document.querySelectorAll('span.rd-navbar-submenu-toggle');

  for (i = 0; i < submenuToggles.length; i++) {
    node = submenuToggles[i];
    node.parentNode.removeChild(node);
  }



});



