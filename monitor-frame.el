;; Monitor frame commands

(defun monitor-frame-position (monitor)
    (if (eq monitor 'left)
        '((top . 4) (left + -2044))
        '((top . 4) (left . 2052))))

(defun monitor-frame-create (monitor)
    "Create a monitor on the specified display"
    (interactive "S")
    (let ((primary (selected-frame))
             (secondary (make-frame)))
        (progn
            (monitor-frame-move secondary monitor)
            (select-frame primary))))

(defun monitor-frame-move (frame monitor)
    (select-frame frame)
    (toggle-frame-fullscreen)
    (modify-frame-parameters frame (monitor-frame-position monitor))
    (toggle-frame-fullscreen))

;; (monitor-frame-move (other-frame 1) 'right)



(provide 'monitor-frame)
