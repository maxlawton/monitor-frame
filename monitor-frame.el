;; Monitor frame commands

(require 'frame)

(defun monitor-frame-on-monitor (monitor)
  "Make a frame on monitor"
  (let* ((geometry (cdr (assq 'geometry monitor)))
          (left (car geometry))
          (top (cadr geometry))
          frame)

    (setq frame (make-frame `((top . ,top) (left . ,left) (fullscreen . nil))))
    (set-frame-parameter frame 'fullscreen 'fullboth)))

(defun monitor-frame-on-all ()
  "Make frames on all monitors"
  (interactive)
  (let ((lengths '()))
    (dolist (monitor (display-monitor-attributes-list))
      (let ((frames (length (cdr (assq 'frames monitor)))))
        (when (eq 0 frames) (monitor-frame-on-monitor monitor))))))

(defun monitor-frame-fullscreen-all ()
  "Make all of the frames fullscreen"
  (interactive)
  (dolist (frame (visible-frame-list))
    (set-frame-parameter frame 'fullscreen 'fullboth)))

(defun monitor-frame-fullscreen-none ()
  "Make none of the frames fullscreen"
  (interactive)
  (dolist (frame (visible-frame-list))
    (set-frame-parameter frame 'fullscreen nil)))

(define-key ctl-x-5-map "a" 'monitor-frame-on-all)

(provide 'monitor-frame)
