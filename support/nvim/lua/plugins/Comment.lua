local ok, comment = pcall(require, "Comment")
if not ok then
	return
end

-- Enable Comment.nvim
comment.setup()
