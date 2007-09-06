# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/sonar/sonar-1.2.2-r1.ebuild,v 1.8 2007/09/06 18:22:10 jokey Exp $

DESCRIPTION="network reconnaissance utility"
HOMEPAGE="http://autosec.sourceforge.net/"
SRC_URI="mirror://sourceforge/autosec/${PF}.tar.bz2"
RESTRICT="mirror"

IUSE="doc"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc"
S=${WORKDIR}/${PF}

DEPEND="virtual/libc
	>=dev-libs/popt-1.7-r1
	virtual/tetex
	doc? ( >=app-doc/doxygen-1.3 )"

src_compile() {
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make install DESTDIR="${D}" || die "emake install failed"
	dodoc ChangeLog README AUTHORS CONTRIB NEWS
	use doc && dohtml doc/html/*
	rm -rf "${D}"/usr/share/sonar
}
