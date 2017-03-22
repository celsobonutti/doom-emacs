;;; feature/snippets/autoload/evil.el

;;;###autoload
(defun +snippets/expand-on-region ()
  "Only use this with `evil-mode'. Expands a snippet around a selected region
and switches to insert mode if there are editable fields."
  (interactive)
  (when (evil-visual-state-p)
    (evil-visual-select evil-visual-beginning evil-visual-end 'inclusive))
  (cl-letf (((symbol-function 'region-beginning) (lambda () evil-visual-beginning))
            ((symbol-function 'region-end)       (lambda () evil-visual-end)))
    (yas-insert-snippet))
  (let* ((snippet (first (yas--snippets-at-point)))
         (fields (yas--snippet-fields snippet)))
    (evil-insert-state +1)
    (unless fields (evil-change-state 'normal))))

