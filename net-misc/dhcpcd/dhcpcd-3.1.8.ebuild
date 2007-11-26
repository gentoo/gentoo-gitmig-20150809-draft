# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/dhcpcd/dhcpcd-3.1.8.ebuild,v 1.1 2007/11/26 14:43:22 lavajoe Exp $

inherit toolchain-funcs

DESCRIPTION="A DHCP client"
HOMEPAGE="http://dhcpcd.berlios.de"
SRC_URI="http://download.berlios.de/${PN}/${P}.tar.bz2"
LICENSE="GPL-2"

KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~sparc-fbsd ~x86 ~x86-fbsd"

SLOT="0"
IUSE="vram zeroconf"

DEPEND=""
PROVIDE="virtual/dhcpc"

src_unpack() {
	unpack ${A}
	cd "${S}"

	if use zeroconf; then
		einfo "ZeroConf support enabled"
	else
		einfo "Disabling zeroconf support"
		{
			echo
			echo "/* User indicated no zeroconf support */"
			echo "#undef ENABLE_IPV4LL"
		} >> config.h
	fi

	# Disable DUID support if we have volatile storage.
	# LiveCD's *should* enable this USE flag
	if use vram; then
		einfo "Disabling DUID support"
		{
			echo
			echo "/* User indicated volatile ram storage */"
			echo "#undef ENABLE_DUID"
		} >> config.h
	else
		einfo "DUID support enabled"
	fi
}

src_compile() {
	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}" || die
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc ChangeLog
}

pkg_postinst() {
	if use zeroconf; then
		ewarn "You have installed dhcpcd with zeroconf support."
		elog "This means that it will always obtain an IP address even if no"
		elog "DHCP server can be contacted, which will break any existing"
		elog "failover support you may have configured in your net configuration."
		elog "This behaviour can be controlled with the -L flag."
		elog "See the dhcpcd man page for more details."
	fi

	if ! use vram; then
		use zeroconf && echo
		ewarn "You have installed dhcpcd with DUID support."
		elog "This means that we will generate a DUID in /var/lib/dhcpcd/dhcpcd.duid"
		elog "This is generated from a MAC address of the card and a timestamp."
		elog "It will be used in every subsequent DHCP transaction, along with a IAID"
		elog "in the ClientID option. This is required by RFC 4361."
		echo
		ewarn "Some DHCP server implementations require a MAC address only in the"
		ewarn "ClientID field. These DHCP servers should be updated to be RFC"
		ewarn "conformant. If you cannot do this, you can revert to the old"
		ewarn "behaviour by using the -I '' option OR building dhcpcd with the"
		ewarn "vram USE flag enabled."
	fi
}
