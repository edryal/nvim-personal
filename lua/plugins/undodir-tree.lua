-- Fixes the annoying E828 error when writing to an undo file
-- when you're working in big project with a lot of nested directories
return {
  "pixelastic/vim-undodir-tree",
  event = "BufEnter",
}
