# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/lucid/lucid-0.1_rc2.ebuild,v 1.1 2007/06/20 17:53:52 hollow Exp $

DESCRIPTION="lucid utility library"
HOMEPAGE="http://svn.linux-vserver.org/projects/${PN}"
SRC_URI="http://people.linux-vserver.org/~hollow/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"

IUSE=""

DEPEND=""

src_unpack() {
	unpack "${A}" || die
	cd "${S}" || die

	econf --disable-doxygen-doc || die "econf failed"
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
	dodoc README ChangeLog AUTHORS
	dohtml -A .gif doc/html/*
}
