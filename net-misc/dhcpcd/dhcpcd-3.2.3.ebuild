# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/dhcpcd/dhcpcd-3.2.3.ebuild,v 1.9 2009/01/08 01:39:08 darkside Exp $

inherit toolchain-funcs

DESCRIPTION="A fully featured, yet light weight RFC2131 compliant DHCP client"
HOMEPAGE="http://roy.marples.name/dhcpcd"
SRC_URI="http://roy.marples.name/${PN}/${P}.tar.bz2"
LICENSE="BSD-2"

KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc ~sparc-fbsd x86 ~x86-fbsd"

SLOT="0"
IUSE="vram zeroconf"

DEPEND=""
PROVIDE="virtual/dhcpc"

src_unpack() {
	unpack ${A}
	cd "${S}"

	if use zeroconf; then
		elog "ZeroConf support enabled"
	else
		elog "Disabling zeroconf support"
		{
			echo
			echo "/* User indicated no zeroconf support */"
			echo "#undef ENABLE_IPV4LL"
		} >> config.h
	fi

	# Disable DUID support if we have volatile storage.
	# LiveCD's *should* enable this USE flag
	if use vram; then
		elog "Disabling DUID support"
		{
			echo
			echo "/* User indicated volatile ram storage */"
			echo "#undef ENABLE_DUID"
		} >> config.h
	else
		elog "DUID support enabled"
	fi
}

src_compile() {
	emake CC="$(tc-getCC)" INFODIR=/var/lib/dhcpcd || die
}

src_install() {
	emake DESTDIR="${D}" install || die
}

pkg_postinst() {
	# Upgrade the duid file to the new format if needed
	local duid="${ROOT}"/var/lib/dhcpcd/dhcpcd.duid
	if [ -e "${duid}" ] && ! grep -q '..:..:..:..:..:..' "${duid}"; then
		sed -i -e 's/\(..\)/\1:/g; s/:$//g' "${duid}"
	fi

	if use zeroconf; then
		elog "You have installed dhcpcd with zeroconf support."
		elog "This means that it will always obtain an IP address even if no"
		elog "DHCP server can be contacted, which will break any existing"
		elog "failover support you may have configured in your net configuration."
		elog "This behaviour can be controlled with the -L flag."
		elog "See the dhcpcd man page for more details."
	fi

	if ! use vram; then
		use zeroconf && echo
		elog "You have installed dhcpcd with DUID support."
		elog "This means that we will generate a DUID in /var/lib/dhcpcd/dhcpcd.duid"
		elog "This is generated from a MAC address of the card and a timestamp."
		elog "It will be used in every subsequent DHCP transaction, along with a IAID"
		elog "in the ClientID option. This is required by RFC 4361."
		echo
		elog "Some DHCP server implementations require a MAC address only in the"
		elog "ClientID field. These DHCP servers should be updated to be RFC"
		elog "conformant. If you cannot do this, you can revert to the old"
		elog "behaviour by using the -I '' option OR building dhcpcd with the"
		elog "vram USE flag enabled."
	fi
}
