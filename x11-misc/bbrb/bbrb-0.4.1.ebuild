# Copyright 2002 Gentoo Technologies, Inc.
# Author: Stacy Keast <slik@telusplanet.net>
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/x11-misc/bbrb/bbrb-0.4.1.ebuild,v 1.2 2002/05/27 17:27:40 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="blackbox background manager."
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
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
