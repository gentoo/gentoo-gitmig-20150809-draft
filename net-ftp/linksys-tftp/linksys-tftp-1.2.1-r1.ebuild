# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/linksys-tftp/linksys-tftp-1.2.1-r1.ebuild,v 1.1 2010/10/04 15:57:22 xmw Exp $

EAPI=2

inherit eutils toolchain-funcs

DESCRIPTION="TFTP client suitable for uploading to the Linksys WRT54G Wireless Router"
HOMEPAGE="http://redsand.net/projects/linksys-tftp/linksys-tftp.php"
SRC_URI="http://redsand.net/projects/${PN}/pub/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="sys-devel/gcc"
RDEPEND=""

src_prepare() {
	epatch "${FILESDIR}"/${PF}-Makefile.patch
}

src_compile() {
	emake CC="$(tc-getCC)" || die
}

src_install() {
	doexe linksys-tftp || die
	dodoc README || die
}
