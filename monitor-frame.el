;; monitor-frame --- Commands for dealing with frames across monitors

;;; Commentary:
;;; Quickly add a frame to each monitor

;;; Code:

(require 'frame)

(defun monitor-frame-on-monitor-geometry (monitor)
  "Make a frame on MONITOR."
  (let* ((geometry (cdr (assq 'geometry monitor)))
          (left (car geometry))
          (top (cadr geometry))
          frame)

    (setq frame (make-frame `((top . ,top) (left . ,left) (fullscreen . nil))))
    (set-frame-parameter frame 'fullscreen 'fullscreen)))

;; (defun monitor-fullscreen-frame-on-monitor (monitor)
;;   "Make a frame on MONITOR."
;;   (let* ((frame (make-frame-on-monitor monitor)))
;;     (set-frame-parameter frame 'fullscreen 'fullscreen)))


(defun monitor-frame-on-monitor (monitor)
  "Make a frame on MONITOR."
  (let* ((workarea (cdr (assq 'workarea monitor)))
          (monitor-name (cdr (assq 'name monitor)))
          (monitor-top  (nth 1 workarea))
          (monitor-left (nth 0 workarea))
          (frame (make-frame-on-monitor monitor-name nil `((user-position . 't) (top . ,monitor-top) (left . ,monitor-left)))))
    (set-frame-parameter frame 'fullscreen 'fullscreen)
    (message "Made frame on %s at %s,%s really %s,%s"
      monitor-name monitor-top monitor-left
      (frame-parameter frame 'top) (frame-parameter frame 'left))))

(defun monitor-frame-on-all ()
  "Make frames on all monitors."
  (interactive)
  (let ((lengths '()))
    (dolist (monitor (display-monitor-attributes-list))
      (let ((frames (length (cdr (assq 'frames monitor)))))
        (when (eq 0 frames) (monitor-frame-on-monitor monitor))))))

(defun monitor-frame-fullscreen-all ()
  "Make all of the frames fullscreen."
  (interactive)
  (dolist (frame (visible-frame-list))
    (set-frame-parameter frame 'fullscreen 'fullscreen)))

(defun monitor-frame-fullscreen-none ()
  "Make none of the frames fullscreen."
  (interactive)
  (dolist (frame (visible-frame-list))
    (set-frame-parameter frame 'fullscreen nil)))

(define-key ctl-x-5-map "a" 'monitor-frame-on-all)

(provide 'monitor-frame)
;;; monitor-frame.el ends here
