# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/lib-compat-loki/lib-compat-loki-0.1.ebuild,v 1.1 2005/02/23 02:47:50 wolf31o2 Exp $

DESCRIPTION="Compatibility libc6 libraries for Loki games"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI="http://www.blfh.de/gentoo/distfiles/${P}.tar.bz2
	http://dev.gentoo.org/~wolf31o2/sources/lib-compat-loki/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86" # ppc
IUSE=""

RDEPEND="virtual/libc"

# I'm not quite sure if this is necessary:
RESTRICT="nostrip"

S=${WORKDIR}/${ARCH}

src_unpack() {
	unpack ${A}
	cd ${S}
	# rename the libs in order to _never_ overwrite any existing lib.
	mv libc-2.2.5.so loki_libc.so.6
	mv ld-2.2.5.so loki_ld-linux.so.2
	mv libnss_files-2.2.5.so loki_libnss_files.so.2
}

src_install() {
	if use x86 ; then
		into /
		dolib.so loki_ld-linux.so.2
		rm -f loki_ld-linux.so.2
	fi
	into /usr
	dolib.so *.so*
	preplib /usr
}
