# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/trafshow/trafshow-4.0.ebuild,v 1.8 2005/04/09 09:54:57 corsair Exp $

inherit eutils gnuconfig

IUSE="slang"


DESCRIPTION="Full screen visualization of the network traffic"
SRC_URI="ftp://ftp.nsk.su/pub/RinetSoftware/${P}.tgz"
HOMEPAGE="http://soft.risp.ru/trafshow/index_en.shtml"

SLOT="3"
LICENSE="as-is"
KEYWORDS="x86 sparc ~ppc ppc64 ~amd64"

DEPEND="virtual/libpcap
	sys-libs/ncurses
	slang? ( >=sys-libs/slang-1.4.2 )"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-gentoo.patch
	use ppc64 && gnuconfig_update
}

src_compile() {
	if ! use slang; then
		# No command-line option so pre-cache instead
		export ac_cv_have_curses=ncurses
		export LIBS=-lncurses
	fi

	econf --enable-ipv6 || die "./configure failed"
	emake || die "emake failed"
}

src_install() {
	make install DESTDIR=${D} || die "make install failed"
}
