;; compile mime-ui-en.texi and mime-ui-ja.texi

(find-file "mime-ui-en.texi")
(texi2info)
(find-file "mime-ui-ja.texi")
(texi2info)
