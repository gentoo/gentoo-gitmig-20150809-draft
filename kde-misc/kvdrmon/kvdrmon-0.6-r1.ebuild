# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kvdrmon/kvdrmon-0.6-r1.ebuild,v 1.4 2008/12/17 21:04:39 zzam Exp $

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
	epatch "${FILESDIR}/${P}-gcc4.3.diff"

	use arts || epatch "${FILESDIR}/${P}-noarts.diff"
}

pkg_postinst() {
	elog
	elog "This program needs a VDR helper plugin. You must install"
	elog "media-plugins/vdr-kvdrmon on the machine running VDR."
	elog
	elog "To work properly the kvdrmon setting for the VDR host"
	elog "must be changed from the default \"localhost\" to the"
	elog "computer VDR is running on."
	elog
}
