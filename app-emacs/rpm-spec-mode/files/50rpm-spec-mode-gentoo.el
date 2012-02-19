(add-to-list 'load-path "@SITELISP@")
(autoload 'rpm-spec-mode "rpm-spec-mode.el" "RPM spec mode." t)
(add-to-list 'auto-mode-alist '("\\.spec\\'" . rpm-spec-mode))

