# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/valgrind/valgrind-2.4.0.ebuild,v 1.4 2005/04/12 18:31:24 griffon26 Exp $

inherit flag-o-matic eutils

DESCRIPTION="An open-source memory debugger for x86-GNU/Linux and ppc-GNU/Linux"
HOMEPAGE="http://valgrind.kde.org"
SRC_URI="x86? ( http://www.valgrind.org/downloads/${P}.tar.bz2 )
		 ppc? ( http://ozlabs.org/~paulus/${P}-ppc-050407.tar.bz2 )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ~x86"
IUSE="X"
RESTRICT="nostrip"

RDEPEND="virtual/libc
	X? ( virtual/x11 )"
DEPEND="${RDEPEND}
	sys-devel/autoconf"

src_unpack() {
	unpack ${A}
	use ppc && cd "${WORKDIR}/${P}-ppc-050407" || cd ${S}

	# make sure our CFLAGS are respected
	einfo "Changing configure to respect CFLAGS"
	sed -i -e 's:CFLAGS="-Wno-long-long":CFLAGS="$CFLAGS -Wno-long-long":' configure

	# Enables valgrind to build with PIE and disables PIE for 
	# tests that fail to build with it
	epatch ${FILESDIR}/${P}-pie-fix.patch
}

src_compile() {
	use ppc && cd "${WORKDIR}/${P}-ppc-050407"

	local myconf

	filter-flags -fstack-protector -fomit-frame-pointer

	use X && myconf="--with-x" || myconf="--with-x=no"

	# note: it does not appear safe to play with CFLAGS
	econf ${myconf} || die
	emake || die "emake failed"
}

src_install() {
	use ppc && cd "${WORKDIR}/${P}-ppc-050407"
	einstall docdir="${D}/usr/share/doc/${PF}/html" || die
	dodoc ACKNOWLEDGEMENTS AUTHORS FAQ.txt NEWS README* TODO
}
