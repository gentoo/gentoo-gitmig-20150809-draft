# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-streamdev-server/vdr-streamdev-server-0.3.3_pre20061206.ebuild,v 1.2 2007/01/05 16:55:30 hd_brummy Exp $

inherit vdr-plugin eutils

VDRPLUGIN_BASE=${VDRPLUGIN//-*/}
MY_PV=${PV/*_pre/}
MY_P=${VDRPLUGIN_BASE}-${MY_PV}

DESCRIPTION="Video Disk Recorder Client/Server streaming plugin"
HOMEPAGE="http://www.magoa.net/linux/"
SRC_URI="mirror://gentoo/vdr-${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=">=media-video/vdr-1.3.24"

S=${WORKDIR}/${MY_P}

VDRPLUGIN_MAKE_TARGET="libvdr-${VDRPLUGIN}.so"

EXTERNREMUX_PATH=/usr/share/vdr/streamdev/externremux.sh

src_unpack() {
	vdr-plugin_src_unpack
	cd ${S}

	#seems to no longer work, if needed, please open a bug
	#if grep -q "virtual bool Active" ${ROOT}/usr/include/vdr/plugin.h; then
	#	epatch ${FILESDIR}/vdr-streamdev-server-20060502-old-vdr-headers.diff
	#fi

	# Moving externremux.sh out of /root
	sed -i remux/extern.c \
		-e "s#/root/externremux.sh#${EXTERNREMUX_PATH}#"

	# make subdir libdvbmpeg respect CXXFLAGS
	sed -i Makefile \
		-e 's:\(CXXFLAGS.*=\):#\1:'
	sed -i libdvbmpeg/Makefile \
		-e 's:CFLAGS =  -g -Wall -O2:CFLAGS = $(CXXFLAGS) :'
}

src_install() {
	vdr-plugin_src_install

	cd ${S}
	insinto /etc/vdr/plugins
	newins streamdevhosts.conf.example streamdevhosts.conf
	chown vdr:vdr ${D}/etc/vdr -R
}

pkg_postinst() {
	vdr-plugin_pkg_postinst
	elog "If you want to use the externremux-feature, then put"
	elog "your custom script as ${EXTERNREMUX_PATH}."
}

