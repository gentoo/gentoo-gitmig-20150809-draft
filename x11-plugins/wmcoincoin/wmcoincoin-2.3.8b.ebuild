# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmcoincoin/wmcoincoin-2.3.8b.ebuild,v 1.1 2002/10/04 19:00:55 raker Exp $

S=${WORKDIR}/${P}

DESCRIPTION="Stupid Dockapp for browsing Dacode sites news and board"
HOMEPAGE="http://hules.free.fr/wmcoincoin"
SRC_URI="mirror://sourceforge/dacode/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="virtual/glibc
	virtual/x11"
RDEPEND="${DEPEND}"

src_compile() {

	econf || die "configure failed"

	emake || die "parallel make failed"

}

src_install () {

	einstall || die "make install failed"

	dobin wmcoincoin
	dobin wmpanpan
	dodoc README
	dodoc AUTHORS
	dodoc Changelog
	docinto examples
	insinto /usr/share/wmcoincoin
	doins options
	doins useragents

}
