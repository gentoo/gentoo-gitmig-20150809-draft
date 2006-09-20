# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-skincurses/vdr-skincurses-0.0.8.ebuild,v 1.1 2006/09/20 08:35:00 zzam Exp $

IUSE=""

inherit vdr-plugin

VDR_V=1.4.2

DESCRIPTION="VDR plugin: show content of menu in a shell window"
HOMEPAGE="http://www.cadsoft.de/vdr/"
SRC_URI="ftp://ftp.cadsoft.de/vdr/Developer/vdr-${VDR_V}.tar.bz2
		ftp://ftp.cadsoft.de/vdr/Developer/vdr-${VDR_V}-1.diff
		ftp://ftp.cadsoft.de/vdr/Developer/vdr-${VDR_V}-2.diff
		ftp://ftp.cadsoft.de/vdr/Developer/vdr-${VDR_V}-3.diff
		"

KEYWORDS="x86"
SLOT="0"
LICENSE="GPL-2"

DEPEND=">=media-video/vdr-1.3.28"

S=${WORKDIR}/vdr-${VDR_V}/PLUGINS/src/${VDRPLUGIN}

src_unpack() {
	unpack vdr-${VDR_V}.tar.bz2
	cd ${WORKDIR}/vdr-${VDR_V}

	epatch ${DISTDIR}/vdr-${VDR_V}-1.diff
	epatch ${DISTDIR}/vdr-${VDR_V}-2.diff
	epatch ${DISTDIR}/vdr-${VDR_V}-3.diff

	vdr-plugin_src_unpack all_but_unpack
}

