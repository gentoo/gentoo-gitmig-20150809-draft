# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-burn/vdr-burn-0.0.9-r2.ebuild,v 1.17 2008/05/15 16:48:38 zzam Exp $

inherit vdr-plugin eutils

MY_PV="0.0.009"
MY_P="${PN}-${MY_PV}"

DESCRIPTION="DVD Burn Plugin"
HOMEPAGE="http://www.xeatre.de/community/burn"
SRC_URI="http://vdr.unetz.com/download/burn/${MY_P}.tgz"

KEYWORDS="~amd64 x86"
SLOT="0"
LICENSE="GPL-2"
IUSE=""

DEPEND=">=media-video/vdr-1.2.6
		>=media-libs/imlib2-1.1.2
		>=media-gfx/imagemagick-6.1.3.2"

RDEPEND=">=media-video/vdrsync-0.1.3_pre1-r5
		media-video/m2vrequantizer
		>=media-video/transcode-0.6.11
		>=media-video/dvdauthor-0.6.10
		>=media-video/mjpegtools-1.8.0-r1
		>=app-cdr/dvd+rw-tools-5.20"

S="${WORKDIR}/burn-${MY_PV}"

PATCHES=("${FILESDIR}/${P}-gentoo.diff")

VDR_CONFD_FILE="${FILESDIR}/confd-${PV}"
VDR_RCADDON_FILE="${FILESDIR}/rc-addon-${PV}.sh"

pkg_setup() {
	vdr-plugin_pkg_setup

	if [[ ! -e /usr/bin/png2yuv ]] ; then
		echo
		eerror "Please reemerge media-video/mjepgtools with USE=\"png\""
		echo
		die "emerge mjepgtools with USE=\"png\""
	fi
}

src_unpack(){
	vdr-plugin_src_unpack

	if grep -q "virtual cString Active" /usr/include/vdr/plugin.h; then
		epatch "${FILESDIR}/${P}_vdr-1.3.47-compile.diff"
	fi
}

src_install() {
	vdr-plugin_src_install

	dobin "${S}"/scripts/*.sh

	insinto /usr/share/vdr/burn
	doins "${S}"/burn/{*.ttf,*.mp2}
	newins "${S}"/burn/menu-button.png menu-button-default.png
	newins "${S}"/burn/menu-bg.png menu-bg-default.png
	dosym menu-bg-default.png /usr/share/vdr/burn/menu-bg.png
	dosym menu-button-default.png /usr/share/vdr/burn/menu-button.png
	chown -R vdr:vdr "${D}"/usr/share/vdr/burn

	insinto /etc/vdr/reccmds
	doins "${FILESDIR}/reccmds.burn.conf"
}

pkg_preinst() {

	if [[ -L "${ROOT}"/etc/vdr/plugins/burn ]]; then
		elog "remove unneeded link /etc/vdr/plugins/burn"
		elog "from prior install"
		unlink "${ROOT}"/etc/vdr/plugins/burn
	fi
}

pkg_postinst() {
	vdr-plugin_pkg_postinst

	echo
	elog "This ebuild comes only with the standard template"
	elog "'emerge vdr-burn-templates' for more templates"
	elog "To change the templates, use the vdr-image plugin"
	echo
}
