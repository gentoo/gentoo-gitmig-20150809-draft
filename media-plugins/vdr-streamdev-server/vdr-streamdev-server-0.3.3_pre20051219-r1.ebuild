# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-streamdev-server/vdr-streamdev-server-0.3.3_pre20051219-r1.ebuild,v 1.1 2006/04/27 14:46:32 zzam Exp $

inherit vdr-plugin eutils

VDRPLUGIN_BASE=${VDRPLUGIN//-*/}
MY_P=${VDRPLUGIN_BASE}-${PV/*_pre/}

DESCRIPTION="Video Disk Recorder Client/Server streaming plugin"
HOMEPAGE="http://www.magoa.net/linux/"
SRC_URI="mirror://gentoo/vdr-${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=media-video/vdr-1.3.24"

S=${WORKDIR}/${MY_P}

VDRPLUGIN_MAKE_TARGET="libvdr-${VDRPLUGIN}.so"

PATCHES="${FILESDIR}/vdr-streamdev-server-20051219-fix-http-errors.diff"

src_unpack() {
	vdr-plugin_src_unpack
	cd ${S}

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

