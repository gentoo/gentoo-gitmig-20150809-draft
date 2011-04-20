# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/iscan-plugin-gt-f500/iscan-plugin-gt-f500-1.0.0.1.ebuild,v 1.1 2011/04/20 23:06:58 flameeyes Exp $

EAPI="4"

inherit rpm versionator

MY_P="${PN}-$(get_version_component_range 1-3)"

DESCRIPTION="Epson Perfection V2480/2580 PHOTO scanner plugin for SANE 'epkowa' backend."
HOMEPAGE="http://www.avasys.jp/english/linux_e/dl_scan.html"
SRC_URI="http://lx1.avasys.jp/iscan/v1180/${PN}-$(replace_version_separator 3 -).i386.rpm"

LICENSE="EPSON EAPL"
SLOT="0"
KEYWORDS="-* ~amd64"

IUSE="minimal"

DEPEND="minimal? ( >=media-gfx/iscan-2.21.0 )"
RDEPEND="${DEPEND}"

S="${WORKDIR}"

src_configure() { :; }
src_compile() { :; }

src_install() {
	# install scanner firmware
	insinto /usr/share/iscan
	doins "${WORKDIR}/usr/share/iscan/"*

	dodoc "usr/share/doc/${MY_P}/"*

	if ! use minimal; then
		# install scanner plugins
		exeinto "/usr/$(get_libdir)/iscan"
		doexe "${WORKDIR}/usr/$(get_libdir)/iscan/"*
	fi
}

pkg_postinst() {
	elog
	elog "Firmware file esfw8b.bin for Epson Perfection 2480/2580 PHOTO"
	elog "has been installed in /usr/share/iscan."
	elog
	use minimal && return

	# Needed for scaner to work properly.
	if [[ ${ROOT} == "/" ]]; then
		iscan-registry --add interpreter usb 0x04b8 0x0121 "/usr/$(get_libdir)/iscan/libesint41.so.2 /usr/share/iscan/esfw41.bin"
	else
		ewarn "Unable to register the plugin and firmware when installing outside of /."
		ewarn "execute the following command yourself:"
		ewarn "iscan-registry --add interpreter usb 0x04b8 0x0121 '/usr/$(get_libdir)/iscan/libesint41.so.2 /usr/share/iscan/esfw41.bin'"
	fi
}

pkg_prerm() {
	use minimal && return

	if [[ ${ROOT} == "/" ]]; then
		iscan-registry --remove interpreter usb 0x04b8 0x0121 "/usr/$(get_libdir)/iscan/libesint41.so.2 /usr/share/iscan/esfw41.bin"
	else
		ewarn "Unable to register the plugin and firmware when installing outside of /."
		ewarn "execute the following command yourself:"
		ewarn "iscan-registry --remove interpreter usb 0x04b8 0x0121 '/usr/$(get_libdir)/iscan/libesint41.so.2 /usr/share/iscan/esfw41.bin'"
	fi
}
