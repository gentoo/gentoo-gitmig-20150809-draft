# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/bmake/bmake-20060728.ebuild,v 1.3 2006/10/23 13:33:40 exg Exp $

inherit eutils

MK_VER=20060318
DESCRIPTION="NetBSD's portable make"
HOMEPAGE="http://www.crufty.net/help/sjg/bmake.html"
SRC_URI="http://void.crufty.net/ftp/pub/sjg/${P}.tar.gz
		http://void.crufty.net/ftp/pub/sjg/mk-${MK_VER}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=""
RDEPEND="!sys-devel/pmake"

S="${WORKDIR}/${PN}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${PN}-makefile.patch
}

src_compile() {
	econf --with-mksrc=../mk  || die "Configure failed"
	emake -f makefile.boot bootstrap || die "Compile failed"
}

src_install() {
	emake -f makefile.boot -j1 DESTDIR="${D}" install-bin install-man || die "Install failed"
	FORCE_BSD_MK=1 SYS_MK_DIR=. ../mk/install-mk -v -m 644 "${D}"/usr/share/mk
}
