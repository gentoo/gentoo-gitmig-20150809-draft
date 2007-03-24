# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/remake/remake-0.62.ebuild,v 1.1 2007/03/24 08:08:29 vapier Exp $

MAKE_V="3.80"
MY_PV=${MAKE_V}+dbg-${PV}
MY_P=${PN}-${MY_PV}

DESCRIPTION="patched version of GNU make that adds improved error reporting, tracing, and a debugger"
HOMEPAGE="http://bashdb.sourceforge.net/remake/"
SRC_URI="mirror://sourceforge/bashdb/${MY_P}.tar.bz2"

LICENSE="GPL-1"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE=""

S=${WORKDIR}/${MY_P}

src_install() {
	emake install DESTDIR="${D}" || die "make install failed"
	dodoc AUTHORS INSTALL NEWS README TODO
	# fix collide with the real make's info pages
	rm -f "${D}"/usr/share/info/make.*
}
