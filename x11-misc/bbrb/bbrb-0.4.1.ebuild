# Copyright 2002 Gentoo Technologies, Inc.
# Author: Stacy Keast <slik@telusplanet.net>
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/x11-misc/bbrb/bbrb-0.4.1.ebuild,v 1.1 2002/04/30 05:22:42 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="blackbox background manager."
SRC_URI="http://prdownloads.sourceforge.net/${PN}/${P}.tar.gz"
HOMEPAGE="http://bbrb.sourceforge.net"

DEPEND="x11-libs/gtk+
	media-libs/imlib"

RDEPEND="media-gfx/xv
	x11-terms/eterm
	virtual/blackbox"

src_install () {
	einstall || die
}

pkg_postinst() {

	if [ -f /usr/bin/fluxbox ]
	then
		einfo
		einfo "Warning: This will NOT work for fluxbox"
		einfo
	fi
}
