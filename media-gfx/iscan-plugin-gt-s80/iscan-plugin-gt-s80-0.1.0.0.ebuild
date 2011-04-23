# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/iscan-plugin-gt-s80/iscan-plugin-gt-s80-0.1.0.0.ebuild,v 1.1 2011/04/23 11:20:05 flameeyes Exp $

EAPI="4"

inherit rpm versionator

MODEL=${PN#iscan-plugin-}
UP_MODEL=$(LC_ALL=C tr '[:lower:]' '[:upper:]' <<<${MODEL})

MY_P="esci-interpreter-${PN#iscan-plugin-}-$(replace_version_separator 3 -)"

DESCRIPTION="Epson GT-S50 and GT-S80 scanner plugins for SANE 'epkowa' backend."
HOMEPAGE="http://www.avasys.jp/english/linux_e/dl_scan.html"
SRC_URI="
	x86? ( http://linux.avasys.jp/drivers/scanner-plugins/${UP_MODEL}/${MY_P}.i386.rpm )
	amd64? ( http://linux.avasys.jp/drivers/scanner-plugins/${UP_MODEL}/${MY_P}.x86_64.rpm )"

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
