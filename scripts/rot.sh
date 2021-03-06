#!/bin/sh

TRANSFORM_NAME='Coordinate Transformation Matrix'

SCREEN='eDP'
TOUCHSCREEN='pointer:ELAN9008:00 04F3:2C82'
MOUSE='ELAN1201:00 04F3:3098 Mouse'
TOUCHPAD='ELAN1201:00 04F3:3098 Touchpad'
PEN='ELAN9008:00 04F3:2C82 Pen (0)'
ERASER='ELAN9008:00 04F3:2C82 Eraser (0)'

apply_rotation() {
	local screen_rotation=$1
	local transform_matrix=$2

	xrandr --output "$SCREEN" --rotate $screen_rotation

	xinput set-prop "$TOUCHSCREEN" "$TRANSFORM_NAME" $transform_matrix
	xinput set-prop "$MOUSE" "$TRANSFORM_NAME" $transform_matrix
	xinput set-prop "$TOUCHPAD" "$TRANSFORM_NAME" $transform_matrix
	xinput set-prop "$PEN" "$TRANSFORM_NAME" $transform_matrix
	xinput set-prop "$ERASER" "$TRANSFORM_NAME" $transform_matrix
}

MATRIX_NORMAL='1 0 0 0 1 0 0 0 1'
MATRIX_INVERT='-1 0 1 0 -1 1 0 0 1'
MATRIX_LEFT='0 -1 1 1 0 0 0 0 1'
MATRIX_RIGHT='0 1 0 -1 0 1 0 0 1'

case $1 in
	up|u|normal|top)
		apply_rotation normal "$MATRIX_NORMAL"
		;;
	down|d|inverted|bottom)
		apply_rotation inverted "$MATRIX_INVERT"
		;;
	left|l)
		apply_rotation left "$MATRIX_LEFT"
		;;
	right|r)
		apply_rotation right "$MATRIX_RIGHT"
		;;
	*)
		echo "usage: rot.sh [up|down|left|right]"
		;;
esac