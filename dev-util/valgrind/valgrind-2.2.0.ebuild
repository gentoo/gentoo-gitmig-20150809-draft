# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/valgrind/valgrind-2.2.0.ebuild,v 1.2 2004/09/02 23:20:55 lu_zero Exp $

inherit flag-o-matic eutils

DESCRIPTION="An open-source memory debugger for x86-GNU/Linux and ppc-GNU/Linux"
HOMEPAGE="http://valgrind.kde.org"
SRC_URI="x86? ( http://developer.kde.org/~sewardj/${P}.tar.bz2 )
		 ppc? ( http://ozlabs.org/~paulus/${P}-ppc.tar.bz2 )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 -sparc ~ppc -alpha"
IUSE="X"
RESTRICT="nostrip"

RDEPEND="virtual/libc
	X? ( virtual/x11 )"
DEPEND="${RDEPEND}
	sys-devel/autoconf"

src_unpack() {
	unpack ${A}
	use ppc && cd "${WORKDIR}/${P}-ppc" || cd ${S}
	#ugly but working workaround
	if has_version '>=sys-kernel/linux26-headers-2.6.7' ; then
		einfo "Removing net/if.h from the includes in vg_unsafe.h"
		sed -i -e "s:#include <net/if.h>::" \
			coregrind/vg_unsafe.h ||die
		less coregrind/vg_unsafe.h ||die
	fi
}
src_compile() {
	use ppc && cd "${WORKDIR}/${P}-ppc"

	local myconf

	filter-flags -fPIC

	use X && myconf="--with-x" || myconf="--with-x=no"
	# note: it does not appear safe to play with CFLAGS
	econf ${myconf} || die
	emake || die "emake failed"
}

src_install() {
	use ppc && cd "${WORKDIR}/${P}-ppc"
	einstall docdir="${D}/usr/share/doc/${PF}/html" || die
	dodoc ACKNOWLEDGEMENTS AUTHORS FAQ.txt NEWS README* TODO
}
