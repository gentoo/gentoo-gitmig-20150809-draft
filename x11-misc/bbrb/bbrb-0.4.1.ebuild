# Copyright 2002 Gentoo Technologies, Inc.
# Author: Stacy Keast <slik@telusplanet.net>
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/x11-misc/bbrb/bbrb-0.4.1.ebuild,v 1.3 2002/06/06 23:18:27 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="blackbox background manager."
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://bbrb.sourceforge.net"

DEPEND="x11-libs/gtk+
	media-libs/imlib"

RDEPEND="media-gfx/xv
	x11-terms/eterm
	virtual/blackbox"

SLOT="0"
LICENSE="GPL-2"

src_install () {
	einstall || die
}

pkg_postinst() {

	( [ -f /usr/bin/fluxbox ] || [ -f /usr/bin/openbox ] ) && ( \
		einfo "Please see http://bbrb.sf.net to make this work with"
		einfo "fluxbox/openbox"
	)
}
