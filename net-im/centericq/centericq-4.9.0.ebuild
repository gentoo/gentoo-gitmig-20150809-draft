# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/centericq/centericq-4.9.0.ebuild,v 1.1 2002/12/26 20:33:23 rphillips Exp $

IUSE="nls"

S=${WORKDIR}/${P}
DESCRIPTION="A ncurses ICQ/Yahoo!/MSN/IRC/Jabber Client"
SRC_URI="http://konst.org.ua/download/${P}.tar.gz"
HOMEPAGE="http://konst.org.ua/eng/software/centericq/info.html"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND="virtual/glibc
	>=sys-libs/ncurses-5.2
	=dev-libs/libsigc++-1.0*
	=dev-libs/glib-1.2*"

RDEPEND="nls? ( sys-devel/gettext )"

src_compile() {
	local myopts=""

	patch -p1 < ${FILESDIR}/${P}-compilefix.patch

	use nls || myopts="--disable-nls"
	
	econf ${myopts} || die "Configure failed"
	emake || die "Compilation failed"
}

src_install () {
	einstall || die "Installation failed"

	dodoc ABOUT-NLS AUTHORS ChangeLog COPYING FAQ README THANKS TODO
}
