# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-misc/twin/twin-0.2.8.ebuild,v 1.6 2002/07/25 19:18:35 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A text-mode window environment"
SRC_URI="http://ftp1.sourceforge.net/twin/${P}.tar.gz
	 http://linuz.sns.it/~max/twin/${P}.tar.gz"
HOMEPAGE="http://linuz.sns.it/~max/twin/" 

SLOT="0"
LICENSE="GPL-2 LGPL-2"
KEYWORDS="x86"

DEPEND="X? ( virtual/x11 )
	>=sys-libs/ncurses-5.2"

src_unpack() {
	unpack ${A}
	cd ${S}
	patch -p1 < ${FILESDIR}/${PF}-gentoo.diff || die
}

src_compile() {
	local conf
	
	conf="\n\n\n\n\n\n\n\n"
	use X \
		&& conf=${conf}"y\n" \
		|| conf=${conf}"n\n"

	conf=${conf}"\n\n\n\n\n"
	echo -e ${conf} > .temp
	cat .temp | make config
	rm .temp
	make clean || die
	make  || die
}

src_install() {
	
	dodir /usr/lib /usr/bin /usr/lib/ /usr/include

	dobin server/twin_real server/twin_wrapper
	dobin clients/twsetroot clients/twevent clients/twmapscrn \
			clients/twedit clients/twterm clients/twattach clients/twsysmon

	dolib lib/libTw.so.1.0.0 

	insinto /usr/include
		doins include/libTwkeys.h include/libTw.h include/libTwerrno.h

	dosym /usr/bin/twin_wrapper /usr/bin/twin
	dosym /usr/bin/twattach /usr/bin/twdetach
	dosym /usr/lib/libTw.so.1.0.0 /usr/lib/libTw.so.1
	dosym /usr/lib/libTw.so.1 /usr/lib/libTw.so

	dodoc BUGS COPYING COPYING.LIB INSTALL README TODO Changelog.txt ${P}.lsm
	docinto clients
	dodoc clients/README.twsetroot clients/twsetroot.sample
}
