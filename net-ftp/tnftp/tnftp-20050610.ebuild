# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/tnftp/tnftp-20050610.ebuild,v 1.2 2005/06/21 18:54:48 swegener Exp $

DESCRIPTION="NetBSD FTP client with several advanced features"
SRC_URI="ftp://ftp.netbsd.org/pub/NetBSD/misc/${PN}/${P}.tar.gz
	ftp://ftp.netbsd.org/pub/NetBSD/misc/old/${PN}/${P}.tar.gz"
HOMEPAGE="ftp://ftp.netbsd.org/pub/NetBSD/misc/tnftp/"

SLOT="0"
LICENSE="as-is"
KEYWORDS="~x86 ~sparc ~ppc ~alpha ~amd64"
IUSE="ipv6"

DEPEND=">=sys-libs/ncurses-5.1"

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
		if [ ! -e "${ROOT}"/usr/bin/${X} ]
		then
			dosym tnftp /usr/bin/${x} || die "dosym failed"
		fi
	done

	dodoc COPYING ChangeLog README THANKS || die "dodoc failed"
}
