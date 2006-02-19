# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-setup/vdr-setup-0.2.3.ebuild,v 1.2 2006/02/19 23:06:29 hd_brummy Exp $

inherit vdr-plugin

DESCRIPTION="Video Disk Recorder Plugin - Create Submenus, Configure VDR on OSD"
HOMEPAGE="http://www.vdrtools.de/vdrsetup.html"
SRC_URI="http://www.vdrtools.de/download/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=">=media-video/vdr-1.3.36-r3"

S=${WORKDIR}/setup-${PV}

PATCHES="${FILESDIR}/${P}-gentoo.diff"

pkg_setup() {
	vdr-plugin_pkg_setup

	if [[ ! -f /usr/include/vdr/submenu.h ]] || [[ ! -f /usr/share/vdr/setup/menu.c ]]; then
		echo
		eerror "Patched VDR needed"
		echo
		einfo "reemerge VDR with USE=\"setup-plugin\" " && die "unpack failed, patched VDR needed"
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
	einfo "Edit /etc/vdr/plugins/setup/*"
	echo
	ewarn "Setup-Plugin will change the path of your channels.conf"
	einfo "You will find a backup copy on /etc/vdr/channels/channels.conf.bak"
	echo
}




