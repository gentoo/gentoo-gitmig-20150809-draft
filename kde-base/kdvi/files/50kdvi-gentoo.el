(require 'kdvi-search)
(add-hook 'LaTeX-mode-hook (lambda () (local-set-key "\C-x\C-j" 'kdvi-jump-to-line)))
(add-hook 'tex-mode-hook (lambda () (local-set-key "\C-x\C-j" 'kdvi-jump-to-line)))
