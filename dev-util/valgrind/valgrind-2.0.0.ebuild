# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/valgrind/valgrind-2.0.0.ebuild,v 1.8 2005/02/13 15:55:25 griffon26 Exp $

inherit flag-o-matic eutils
RESTRICT="nostrip"
IUSE="X"

MY_P=${P/2.0_pre/}
S=${WORKDIR}/${MY_P}

DESCRIPTION="An open-source memory debugger for x86-GNU/Linux"
HOMEPAGE="http://valgrind.kde.org"
SRC_URI="http://developer.kde.org/~sewardj/${MY_P}.tar.bz2"
DEPEND="virtual/libc
	sys-devel/autoconf
	X? ( virtual/x11 )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 -sparc -ppc -alpha"

#src_unpack() {
#	unpack ${A}
#	cd ${S}
#	if [ `uname -r | awk -F . '{print $2}'` == 6 ]; then
#		epatch ${FILESDIR}/${PN}-configure.in-2.6.diff
#		autoconf || die "error while running autoconf"
#	fi
#}

src_compile() {
	local myconf

	filter-flags -fPIC

	use X && myconf="--with-x" || myconf="--with-x=no"
	# note: it does not appear safe to play with CFLAGS
	econf ${myconf} || die
	emake || die
}

src_install() {
	einstall docdir="${D}/usr/share/doc/${PF}" || die
	dodoc ACKNOWLEDGEMENTS AUTHORS INSTALL NEWS \
		PATCHES_APPLIED README* TODO ChangeLog FAQ.txt
}

