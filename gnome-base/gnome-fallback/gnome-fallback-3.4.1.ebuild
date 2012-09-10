# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gnome-fallback/gnome-fallback-3.4.1.ebuild,v 1.1 2012/09/10 04:17:56 tetromino Exp $

EAPI="4"

DESCRIPTION="Sub-meta package for GNOME 3 fallback mode"
HOMEPAGE="http://www.gnome.org/"
LICENSE="as-is"
SLOT="3.0"
IUSE="cups"

# when unmasking for an arch
# double check none of the deps are still masked !
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"

# Note to developers:
# This is a wrapper for the GNOME 3 fallback apps list
RDEPEND="
	>=gnome-base/gnome-core-libs-${PV}[cups?]

	>=x11-wm/metacity-2.34.3
	>=x11-misc/notification-daemon-0.7
	>=gnome-extra/polkit-gnome-0.105
	>=gnome-base/gnome-panel-${PV}
"
DEPEND=""
S=${WORKDIR}
