# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/dhcpcd/dhcpcd-3.1.5-r1.ebuild,v 1.4 2009/01/08 01:39:08 darkside Exp $

inherit toolchain-funcs

DESCRIPTION="A fully featured, yet light weight RFC2131 compliant DHCP client"
HOMEPAGE="http://dhcpcd.berlios.de"
SRC_URI="http://download.berlios.de/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 s390 sh sparc ~sparc-fbsd x86 ~x86-fbsd"
IUSE="vram"

DEPEND=""
PROVIDE="virtual/dhcpc"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Redefine the location of ntp.drift
	{
		echo
		echo "/* Gentoo stores ntpd drift file here */"
		echo "#undef NTPDRIFTFILE"
		echo "#define NTPDRIFTFILE \"/var/lib/ntp/ntp.drift\""
	} >> config.h

	# Disable DUID support if we have volatile storage.
	# LiveCD's *should* enable this USE flag
	if use vram; then
		einfo "Disabling DUID support in dhcpcd"
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
	use vram && return 0

	ewarn "You have installed dhcpcd with DUID support."
	einfo "This means that we will generate a DUID in /var/lib/dhcpcd/dhcpcd.duid"
	einfo "This is generated from a MAC address of the card and a timestamp."
	einfo "It will be used in every subsequent DHCP transaction, along with a IAID"
	einfo "in the ClientID option. This is required by RFC 4361."
	echo
	ewarn "Some DHCP server implementations require a MAC address only in the"
	ewarn "ClientID field. These DHCP servers should be updated to be RFC"
	ewarn "conformant. If you cannot do this, you can revert to the old"
	ewarn "behaviour by using the -I '' option OR building dhcpcd with the"
	ewarn "vram USE flag enabled."
}
