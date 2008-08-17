# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-block/ms-sys/ms-sys-2.1.3.ebuild,v 1.4 2008/08/17 17:11:16 maekke Exp $

inherit toolchain-funcs

DESCRIPTION="a command-line program for writing Microsoft compatible boot records."
HOMEPAGE="http://ms-sys.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND=""
DEPEND="sys-devel/gettext"

src_compile() {
	tc-export CC
	emake PREFIX="/usr" || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" MANDIR="/usr/share/man" \
		PREFIX="/usr" install || die "emake install failed."
	dodoc CHANGELOG CONTRIBUTORS FAQ README TODO
}
