# Copyright 2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/bbrb/bbrb-0.4.1.ebuild,v 1.9 2002/12/09 04:41:50 manson Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Background manager for blackbox/fluxbox/openbox"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://bbrb.sourceforge.net"

DEPEND="x11-libs/gtk+
	media-libs/imlib"

RDEPEND="media-gfx/xv
	x11-terms/eterm
	virtual/blackbox"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc "

src_install () {
	einstall || die
}

pkg_postinst() {

	( [ -f /usr/bin/fluxbox ] || [ -f /usr/bin/openbox ] ) && ( \
		einfo "Please see http://bbrb.sf.net to make this work with"
		einfo "fluxbox/openbox"
	)
}
