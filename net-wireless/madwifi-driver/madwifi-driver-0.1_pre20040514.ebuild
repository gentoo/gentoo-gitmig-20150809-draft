# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/madwifi-driver/madwifi-driver-0.1_pre20040514.ebuild,v 1.2 2004/05/15 19:02:07 latexer Exp $

DESCRIPTION="Wireless driver for Atheros chipset a/b/g cards"
HOMEPAGE="http://madwifi.sourceforge.net/"

# Point to any required sources; these will be automatically downloaded by
# Portage.
SRC_URI="mirror://gentoo/$P.tar.bz2"

LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~x86"
IUSE=""
DEPEND=""

S=${WORKDIR}

pkg_setup() {

	if [[ "${KV}" > "2.5" ]] ; then
		cd /usr/src/linux
		./scripts/modpost ./vmlinux
	fi

}

src_unpack() {
	check_KV
	unpack ${A}
}

src_compile() {
	unset ARCH
	make clean
	make KERNELPATH="/usr/src/linux" KERNELRELEASE="${KV}" || die
}

src_install() {
	unset ARCH
	make KERNELPATH="/usr/src/linux" KERNELRELEASE="${KV}" \
		DESTDIR="${D}" install || die

	dodoc README
}

pkg_postinst() {

	test -r "${ROOT}/usr/src/linux/System.map" && \
		depmod -ae -F "${ROOT}/usr/src/linux/System.map" -b "${ROOT}" -r ${KV}

	einfo ""
	einfo "The madwifi drivers create an interface named 'athX'"
	einfo "Create /etc/init.d/net.ath0 and add a line for athX"
	einfo "in /etc/conf.d/net like 'iface_ath0=\"dhcp\"'"
	einfo ""
}
