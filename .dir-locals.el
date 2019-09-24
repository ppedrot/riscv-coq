((coq-mode . ((eval . (let* ((project-root (locate-dominating-file buffer-file-name "_CoqProject"))
                             (coqutil-folder (expand-file-name "../coqutil/src" project-root))
                             (coq-path (split-string (or (getenv "COQPATH") "") path-separator t)))
                        (unless (member coqutil-folder coq-path)
                          (setenv "COQPATH" (mapconcat #'identity (cons coqutil-folder coq-path) path-separator))))))))