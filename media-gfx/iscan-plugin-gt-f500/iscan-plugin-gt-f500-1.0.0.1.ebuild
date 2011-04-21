# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/iscan-plugin-gt-f500/iscan-plugin-gt-f500-1.0.0.1.ebuild,v 1.2 2011/04/21 14:28:16 flameeyes Exp $

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

	use minimal && return
	# install scanner plugins
	exeinto "/usr/$(get_libdir)/iscan"
	doexe "${WORKDIR}/usr/$(get_libdir)/iscan/"*
}

pkg_setup() {
	basecmd="iscan-registry --COMMAND interpreter usb 0x04b8 0x0121 '/usr/$(get_libdir)/iscan/libesint41.so.2 /usr/share/iscan/esfw41.bin'"
}

pkg_postinst() {
	elog
	elog "Firmware file esfw41.bin for Epson Perfection 2480/2580 PHOTO"
	elog "has been installed in /usr/share/iscan."
	elog
	use minimal && return
	[[ -n ${REPLACING_VERSIONS} ]] && return

	# Needed for scanner to work properly.
	if [[ ${ROOT} == "/" ]]; then
		eval ${basecmd/COMMAND/add}
	else
		ewarn "Unable to register the plugin and firmware when installing outside of /."
		ewarn "execute the following command yourself:"
		ewarn "${basecmd/COMMAND/add}"
	fi
}

pkg_prerm() {
	use minimal && return
	[[ -n ${REPLACED_BY_VERSION} ]] && return

	if [[ ${ROOT} == "/" ]]; then
		eval ${basecmd/COMMAND/remove}
	else
		ewarn "Unable to de-register the plugin and firmware when installing outside of /."
		ewarn "execute the following command yourself:"
		ewarn "${basecmd/COMMAND/remove}"
	fi
}
