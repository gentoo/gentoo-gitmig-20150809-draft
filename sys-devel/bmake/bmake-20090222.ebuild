# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/bmake/bmake-20090222.ebuild,v 1.1 2009/05/12 10:14:40 aballier Exp $

inherit eutils

MK_VER=20081111
DESCRIPTION="NetBSD's portable make"
HOMEPAGE="http://www.crufty.net/help/sjg/bmake.html"
SRC_URI="http://void.crufty.net/ftp/pub/sjg/${P}.tar.gz
		http://void.crufty.net/ftp/pub/sjg/mk-${MK_VER}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

S="${WORKDIR}/${PN}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${PN}-20080515-makefile.patch
	epatch "${FILESDIR}"/${PN}-tests.patch
}

src_compile() {
	econf --with-mksrc=../mk --with-default-sys-path=/usr/share/mk/${PN} || die "Configure failed"
	emake -f makefile.boot bootstrap || die "Compile failed"
}

src_test() {
	# $A set by portage confuses the tests...
	env -u A emake -f makefile.boot check || die "Tests failed"
}

src_install() {
	emake -f makefile.boot -j1 DESTDIR="${D}" install-bin install-man || die "Install failed"
	FORCE_BSD_MK=1 SYS_MK_DIR=. sh ../mk/install-mk -v -m 644 "${D}"/usr/share/mk/${PN} || die "failed to install mk files"
}
