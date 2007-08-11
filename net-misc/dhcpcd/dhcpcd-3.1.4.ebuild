# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/dhcpcd/dhcpcd-3.1.4.ebuild,v 1.2 2007/08/11 10:23:51 uberlord Exp $

inherit toolchain-funcs

DESCRIPTION="A DHCP client"
HOMEPAGE="http://dhcpcd.berlios.de"
SRC_URI="http://download.berlios.de/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~sparc-fbsd ~x86 ~x86-fbsd"
IUSE="vram"

DEPEND=""
PROVIDE="virtual/dhcpc"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Redefine the location of ntp.drift
	sed -i -e 's,#define NTPDRIFTFILE[:space:]*,#define NTPDRIFTFILE\t\"/var/lib/ntp/ntp.drift\",' \
		config.h || die "sed failed"

	# Disable DUID support if we have volatile storage.
	# LiveCD's *should* enable this USE flag
	use vram && echo "#undef ENABLE_DUID" >> config.h
}

src_compile() {
	local librt=
	use elibc_glibc && librt="LIBRT=-lrt"
	make CC="$(tc-getCC)" CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}" ${librt} || die
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc ChangeLog
}
