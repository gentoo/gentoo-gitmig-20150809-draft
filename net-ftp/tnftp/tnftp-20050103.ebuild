# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/tnftp/tnftp-20050103.ebuild,v 1.4 2005/03/21 14:14:45 swegener Exp $

DESCRIPTION="NetBSD FTP client with several advanced features"
SRC_URI="ftp://ftp.netbsd.org/pub/NetBSD/misc/${PN}/${P}.tar.gz"
HOMEPAGE="ftp://ftp.netbsd.org/pub/NetBSD/misc/tnftp/"

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 sparc ~ppc alpha ~amd64"
IUSE="ipv6"

RDEPEND="virtual/libc
	>=sys-libs/ncurses-5.1"

DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}

	# Adds a command line option: -s, which produces clean, informative output.
	# Shows progess status, ETA, transfer speed, no server responses or login messages.
	# ~woodchip
	sed -i \
		-e "s/46AadefginN:o:pP:q:r:RtT:u:vV/46AadefginN:o:pP:r:RstT:u:vV/" \
		-e "s/case 't'/case 's':\n\t\t\tverbose = 0;\n\t\t\tprogress = 1;\n\t\t\tbreak;\n\n\t\t&/" \
		${S}/src/main.c || die "sed failed in src_unpack"
}

src_compile() {
	econf \
		--enable-editcomplete \
		$(use_enable ipv6) \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	newbin src/ftp tnftp || die "newbin failed"
	newman src/ftp.1 tnftp.1 || die "newman failed"

	for x in ftp lukemftp
	do
		if [ ! -e ${ROOT}/usr/bin/${X} ]
		then
			dosym tnftp /usr/bin/${x} || die "dosym failed"
		fi
	done

	dodoc COPYING ChangeLog README THANKS || die "dodoc failed"
}
