# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/ratpoison/ratpoison-1.3.0_beta3.ebuild,v 1.2 2004/03/15 02:12:41 bcowan Exp $

DESCRIPTION="Ratpoison is an extremely light-weight and barebones wm modelled after screen"
HOMEPAGE="http://ratpoison.sourceforge.net/"
LICENSE="GPL-2"

MY_P="${PN}-${PV/_/-}"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

SLOT="0"
KEYWORDS="~x86 ~sparc ~ppc"
IUSE=""
S=${WORKDIR}/${MY_P}

src_compile() {
	econf
	emake CFLAGS="${CFLAGS} -I/usr/X11R6/include" || die
}

src_install() {
	einstall

	dodoc INSTALL TODO README NEWS AUTHORS ChangeLog
	docinto example
	dodoc contrib/{genrpbindings,ratpoison.el,split.sh} doc/{ipaq.ratpoisonrc,sample.ratpoisonrc}

	rm -rf $D/usr/share/{doc/ratpoison,ratpoison}
}
