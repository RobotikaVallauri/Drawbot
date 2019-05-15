(Scribbled version of C:\Users\Ale\AppData\Local\Temp\ink_ext_XXXXXX.svgEF2NJZ @ 3500.00)
( unicorn.py --tab="plotter_setup" --pen-up-angle=50 --pen-down-angle=30 --start-delay=150 --stop-delay=149.80000305175781 --xy-feedrate=3500 --z-feedrate=150 --z-height=0 --finished-height=0 --register-pen=true --x-home=0 --y-home=0 --num-copies=1 --continuous=false --pause-on-layer-change=false C:\Users\Ale\AppData\Local\Temp\ink_ext_XXXXXX.svgEF2NJZ )
G21 (metric ftw)
G90 (absolute mode)
G92 X0.00 Y0.00 Z0.00 (you are here)

M300 S30 (pen down)
G4 P150 (wait 150ms)
M300 S50 (pen up)
G4 P149 (wait 149ms)
M18 (disengage drives)
M01 (Was registration test successful?)
M17 (engage drives if YES, and continue)

(Polyline consisting of 1 segments.)
G1 X18.74 Y11.22 F3500.00
M300 S30.00 (pen down)
G4 P150 (wait 150ms)
G1 X18.74 Y19.30 F3500.00
G1 X17.13 Y19.30 F3500.00
G1 X15.22 Y13.58 F3500.00
G1 X14.83 Y12.39 F3500.00
G1 X14.40 Y13.68 F3500.00
G1 X12.47 Y19.30 F3500.00
G1 X11.03 Y19.30 F3500.00
G1 X11.03 Y11.22 F3500.00
G1 X12.06 Y11.22 F3500.00
G1 X12.06 Y17.99 F3500.00
G1 X14.41 Y11.22 F3500.00
G1 X15.37 Y11.22 F3500.00
G1 X17.71 Y18.10 F3500.00
G1 X17.71 Y11.22 F3500.00
G1 X18.74 Y11.22 F3500.00
M300 S50.00 (pen up)
G4 P149 (wait 149ms)

(Polyline consisting of 1 segments.)
G1 X9.24 Y11.22 F3500.00
M300 S30.00 (pen down)
G4 P150 (wait 150ms)
G1 X9.24 Y19.30 F3500.00
G1 X3.79 Y19.30 F3500.00
G1 X3.79 Y18.35 F3500.00
G1 X8.17 Y18.35 F3500.00
G1 X8.17 Y15.85 F3500.00
G1 X4.38 Y15.85 F3500.00
G1 X4.38 Y14.89 F3500.00
G1 X8.17 Y14.89 F3500.00
G1 X8.17 Y11.22 F3500.00
G1 X9.24 Y11.22 F3500.00
M300 S50.00 (pen up)
G4 P149 (wait 149ms)


(end of print job)
M300 S50.00 (pen up)
G4 P149 (wait 149ms)
M300 S255 (turn off servo)
G1 X0 Y0 F3500.00
G1 Z0.00 F150.00 (go up to finished level)
G1 X0.00 Y0.00 F3500.00 (go home)
M18 (drives off)
