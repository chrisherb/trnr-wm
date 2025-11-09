/* See LICENSE file for copyright and license details. */
/* Default settings; can be overriden by command line. */

#include "../common/theme.h"

static int topbar = 0;                      /* -b  option; if 0, dmenu appears at bottom     */
static int centered = 1;
static int min_width = 640;
static const float menu_height_ratio = 2.0f;

/* -fn option overrides fonts[0]; default X11 font or font set */
static const char *fonts[] = { font };
static const char *prompt      = NULL;      /* -p  option; prompt to the left of input field */
static const char *colors[SchemeLast][2] = {
	/*                  fg              bg       */
	[SchemeNorm] = {    color_bright,   color_dark },
	[SchemeSel] = {     color_dark,     color_primary },
	[SchemeOut] = {     color_dark,     color_primary },
};
/* -l option; if nonzero, dmenu uses vertical list with given number of lines */
static unsigned int lines      = 10;

/*
 * Characters not considered part of a word while deleting words
 * for example: " /?\"&[]"
 */
static const char worddelimiters[] = " ";

static unsigned int border_width = 1;

