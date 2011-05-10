# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-block/ms-sys/ms-sys-2.2.1.ebuild,v 1.1 2011/05/10 09:53:35 xmw Exp $

EAPI=2

inherit toolchain-funcs

DESCRIPTION="a command-line program for writing Microsoft compatible boot records."
HOMEPAGE="http://ms-sys.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=""
DEPEND="sys-devel/gettext"

src_compile() {
	tc-export CC
	emake PREFIX="/usr" || die
}

src_install() {
	emake DESTDIR="${D}" MANDIR="/usr/share/man" \
		PREFIX="/usr" install || die
	dodoc CHANGELOG CONTRIBUTORS FAQ README TODO || die
}
