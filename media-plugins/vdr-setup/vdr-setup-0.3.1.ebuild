# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-setup/vdr-setup-0.3.1.ebuild,v 1.7 2007/01/05 16:47:35 hd_brummy Exp $

inherit vdr-plugin

DESCRIPTION="VDR plugin: Create Submenus, Configure VDR on OSD"
HOMEPAGE="http://www.vdrtools.de/vdrsetup.html"
SRC_URI="http://www.vdrtools.de/download/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~amd64"
IUSE=""

DEPEND=">=media-video/vdr-1.3.36"

S=${WORKDIR}/setup-${PV}

PATCHES="${FILESDIR}/${P}-*.diff"

pkg_setup() {
	vdr-plugin_pkg_setup

	local header=/usr/include/vdr/submenu.h
	if [[ -f ${header} ]] && grep -q cSubMenuNode ${header} && [[ -f /usr/share/vdr/setup/menu.c ]]; then
		einfo "Patched vdr found"
	else
		echo
		eerror "Patched VDR needed"
		echo
		elog "reemerge VDR with USE=\"setup-plugin\" " && die "unpack failed, patched VDR needed"
	fi
}

src_install() {
	vdr-plugin_src_install

	keepdir /etc/vdr/channels.d

	insinto /var/vdr
	newins ${S}/Examples/sysconfig sysconfig-setup
	fowners vdr:vdr /var/vdr/sysconfig-setup

	insinto /etc/vdr/plugins/setup
	doins ${FILESDIR}/vdr-setup.xml

	insinto /etc/vdr/plugins/setup/help
	doins ${S}/Examples/help/*.hlp

	chown -R vdr:vdr ${D}/etc/vdr

	dodoc MANUAL.DE Examples/*.xml
}

pkg_preinst() {

	if [[ ! -L ${ROOT}/etc/vdr/channels.conf ]]; then
	cp ${ROOT}/etc/vdr/channels.conf ${IMAGE}/etc/vdr/channels.d/channels.conf.bak
	cp ${ROOT}/etc/vdr/channels.conf ${IMAGE}/etc/vdr/channels.d/channels.conf
	fowners vdr:vdr /etc/vdr/channels.d/{channels.conf,channels.conf.bak}
	fi
}

pkg_postinst() {
	vdr-plugin_pkg_postinst

	echo
	elog "Edit /etc/vdr/plugins/setup/*"
	echo
	eerror "vdr-setup is very sensible on Error's in your setup.conf"
	elog "Best way to fix this: Stop (at first) VDR , move setup.conf to setup.conf.bak"
	elog "and let create VDR a new setup.conf on next Start automatically"
	echo
	ewarn "Setup-Plugin will change the path of your channels.conf"
	elog "You will find a backup copy on /etc/vdr/channels/channels.conf.bak"
	echo
}
