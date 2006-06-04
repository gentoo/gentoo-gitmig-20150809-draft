# Copyright 2006-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/matchbox/matchbox-1.0.ebuild,v 1.1 2006/06/04 22:08:57 yvasilev Exp $

DESCRIPTION="Meta package for the Matchbox desktop, a light weight desktop environment designed for use on PDA computers"
HOMEPAGE="http://projects.o-hand.com/matchbox/"
LICENSE="as-is"
SLOT="0"
IUSE="minimal xine"

# when unmasking for an arch
# double check none of the deps are still masked !
KEYWORDS="~x86"

RDEPEND="x11-wm/matchbox-common
	x11-wm/matchbox-desktop
	x11-wm/matchbox-panel
	x11-wm/matchbox-window-manager
	!minimal? ( x11-misc/matchbox-keyboard
		x11-misc/matchbox-panel-manager
		x11-themes/matchbox-themes-extra
		x11-plugins/matchbox-applet-input-manager
		x11-plugins/matchbox-applet-startup-monitor
		x11-plugins/matchbox-applet-volume )"

# Alpha quality plug-ins:
#		x11-plugins/matchbox-desktop-image-browser  
#		xine? ( x11-plugins/matchbox-desktop-xine ) )"

S=${WORKDIR}
