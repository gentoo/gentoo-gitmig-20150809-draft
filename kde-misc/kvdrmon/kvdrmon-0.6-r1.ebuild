# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kvdrmon/kvdrmon-0.6-r1.ebuild,v 1.1 2006/10/23 18:49:54 hd_brummy Exp $

inherit kde

DESCRIPTION="KDE applet for monitoring the VDR video disk recorder"
HOMEPAGE="http://vdr-statusleds.sf.net/kvdrmon"
SRC_URI="mirror://sourceforge/vdr-statusleds/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE="arts"

DEPEND=""

need-kde 3.4

src_unpack() {
	unpack ${A}

	use arts || epatch ${FILESDIR}/${P}-noarts.diff
}


pkg_postinst() {
	einfo
	einfo "This program needs a VDR helper plugin. You must install"
	einfo "media-plugins/vdr-kvdrmon on the machine running VDR."
	einfo
	einfo "To work properly the kvdrmon setting for the VDR host"
	einfo "must be changed from the default \"localhost\" to the"
	einfo "computer VDR is running on."
	einfo
}
