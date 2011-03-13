# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/dhcpcd/dhcpcd-5.2.10-r2.ebuild,v 1.7 2011/03/13 20:32:56 maekke Exp $

EAPI=1

inherit eutils

MY_P="${P/_alpha/-alpha}"
MY_P="${MY_P/_beta/-beta}"
MY_P="${MY_P/_rc/-rc}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="A fully featured, yet light weight RFC2131 compliant DHCP client"
HOMEPAGE="http://roy.marples.name/projects/dhcpcd/"
SRC_URI="http://roy.marples.name/downloads/${PN}/${MY_P}.tar.bz2"
LICENSE="BSD-2"

KEYWORDS="alpha amd64 arm hppa ~ia64 ~mips ppc ~ppc64 ~s390 ~sh ~sparc x86 ~sparc-fbsd ~x86-fbsd"

SLOT="0"
IUSE="+zeroconf elibc_glibc"

DEPEND=""
RDEPEND="!<sys-apps/openrc-0.6.0"
PROVIDE="virtual/dhcpc"

src_unpack() {
	unpack ${A}
	cd "${S}"

	if ! use zeroconf; then
		elog "Disabling zeroconf support"
		{
			echo
			echo "# dhcpcd ebuild requested no zeroconf"
			echo "noipv4ll"
		} >> dhcpcd.conf
	fi
}

src_compile() {
	local hooks="--with-hook=ntp.conf"
	use elibc_glibc && hooks="${hooks} --with-hook=yp.conf"
	econf --prefix= --libexecdir=/$(get_libdir)/dhcpcd --dbdir=/var/lib/dhcpcd \
		--localstatedir=/var ${hooks}
	emake || die
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc README
	newinitd "${FILESDIR}"/${PN}.initd-1 ${PN}
}

pkg_postinst() {
	# Upgrade the duid file to the new format if needed
	local old_duid="${ROOT}"/var/lib/dhcpcd/dhcpcd.duid
	local new_duid="${ROOT}"/etc/dhcpcd.duid
	if [ -e "${old_duid}" ] && ! grep -q '..:..:..:..:..:..' "${old_duid}"; then
		sed -i -e 's/\(..\)/\1:/g; s/:$//g' "${old_duid}"
	fi

	# Move the duid to /etc, a more sensible location
	if [ -e "${old_duid}" -a ! -e "${new_duid}" ]; then
		cp -p "${old_duid}" "${new_duid}"
	fi

	if use zeroconf; then
		elog "You have installed dhcpcd with zeroconf support."
		elog "This means that it will always obtain an IP address even if no"
		elog "DHCP server can be contacted, which will break any existing"
		elog "failover support you may have configured in your net configuration."
		elog "This behaviour can be controlled with the -L flag."
		elog "See the dhcpcd man page for more details."
	fi

	elog
	elog "Users upgrading from 4.0 series should pay attention to removal"
	elog "of compat useflag. This changes behavior of dhcp in wide manner:"
	elog "dhcpcd no longer sends a default ClientID for ethernet interfaces."
	elog "This is so we can re-use the address the kernel DHCP client found."
	elog "To retain the old behaviour of sending a default ClientID based on the"
	elog "hardware address for interface, simply add the keyword clientid"
	elog "to dhcpcd.conf or use commandline parameter -I ''"
	elog
	elog "Also, users upgrading from 4.0 series should be aware that"
	elog "the -N, -R and -Y command line options no longer exist."
	elog "These are controled now by nohook options in dhcpcd.conf."
}
