# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/iscan-plugin-gt-s80/iscan-plugin-gt-s80-0.1.1.2.ebuild,v 1.1 2011/07/27 19:21:21 flameeyes Exp $

EAPI="4"

inherit rpm versionator

MY_PN="esci-interpreter-${PN#iscan-plugin-}"
MY_P="${MY_PN}-$(replace_version_separator 3 -)"

DESCRIPTION="Epson GT-S50 and GT-S80 scanner plugins for SANE 'epkowa' backend."
HOMEPAGE="http://www.avasys.jp/english/linux_e/dl_scan.html"
SRC_URI="
	x86? ( http://linux.avasys.jp/drivers/iscan-plugins/${MY_PN}/$(get_version_component_range 1-3)/${MY_P}.i386.rpm )
	amd64? ( http://linux.avasys.jp/drivers/iscan-plugins/${MY_PN}/$(get_version_component_range 1-3)/${MY_P}.x86_64.rpm )"

LICENSE="AVASYS"
SLOT="0"
KEYWORDS="-* ~amd64"

IUSE=""

DEPEND=">=media-gfx/iscan-2.21.0"
RDEPEND="${DEPEND}"

S="${WORKDIR}"

QA_PRESTRIPPED="/opt/iscan/esci/*"

src_configure() { :; }
src_compile() { :; }

src_install() {
	dodoc usr/share/doc/*/*

	# install scanner plugins
	exeinto /opt/iscan/esci
	doexe "${WORKDIR}/usr/$(get_libdir)/esci/"*
}

pkg_setup() {
	basecmds=(
		"iscan-registry --COMMAND interpreter usb 0x04b8 0x0136 /opt/iscan/esci/libesci-interpreter-gt-s80"
		"iscan-registry --COMMAND interpreter usb 0x04b8 0x0137 /opt/iscan/esci/libesci-interpreter-gt-s50"
	)
}

pkg_postinst() {
	[[ -n ${REPLACING_VERSIONS} ]] && return

	if [[ ${ROOT} == "/" ]]; then
		for basecmd in "${basecmds[@]}"; do
			eval ${basecmd/COMMAND/add}
		done
	else
		ewarn "Unable to register the plugin and firmware when installing outside of /."
		ewarn "execute the following command yourself:"
		for basecmd in "${basecmds[@]}"; do
			ewarn "${basecmd/COMMAND/add}"
		done
	fi
}

pkg_prerm() {
	[[ -n ${REPLACED_BY_VERSION} ]] && return

	if [[ ${ROOT} == "/" ]]; then
		for basecmd in "${basecmds[@]}"; do
			eval ${basecmd/COMMAND/remove}
		done
	else
		ewarn "Unable to register the plugin and firmware when installing outside of /."
		ewarn "execute the following command yourself:"
		for basecmd in "${basecmds[@]}"; do
			ewarn "${basecmd/COMMAND/remove}"
		done
	fi
}
