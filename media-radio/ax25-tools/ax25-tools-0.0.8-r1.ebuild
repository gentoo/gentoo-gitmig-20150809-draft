# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-radio/ax25-tools/ax25-tools-0.0.8-r1.ebuild,v 1.6 2004/10/18 12:28:25 dholm Exp $

DESCRIPTION="Basic AX.25 (Amateur Radio) administrative tools and daemons"
HOMEPAGE="http://ax25.sourceforge.net/"
SRC_URI="mirror://sourceforge/ax25/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE="X"

DEPEND="virtual/libc
	sys-libs/zlib
	>=dev-libs/libax25-0.0.5
	X? ( virtual/x11 )"

src_compile() {
	# If X is disabled, do not build smdiag
	local COMPFLAGS=""
	use X || COMPFLAGS="--without-x"
	econf ${COMPFLAGS} || die
	emake || die
}


src_install() {
	make DESTDIR=${D} install installconf || die

	rm -rf ${D}/usr/share/doc/ax25-tools

	dodoc AUTHORS ChangeLog NEWS README tcpip/ttylinkd.README \
	user_call/README.user_call yamdrv/README.yamdrv dmascc/README.dmascc \
	ax25-tools/ttylinkd.INSTALL

	exeinto /etc/init.d ; newexe ${FILESDIR}/ax25d.rc ax25d
	newexe ${FILESDIR}/mheardd.rc mheardd
	newexe ${FILESDIR}/netromd.rc netromd
	newexe ${FILESDIR}/rip98d.rc rip98d
	newexe ${FILESDIR}/rxecho.rc rxecho
	newexe ${FILESDIR}/ttylinkd.rc ttylinkd
}
