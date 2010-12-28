# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-epgsync/vdr-epgsync-0.0.4.ebuild,v 1.2 2010/12/28 10:26:48 hd_brummy Exp $

EAPI="2"

inherit vdr-plugin

DESCRIPTION="VDR Plugin: Import the EPG of another VDR via vdr-svdrpservice"
HOMEPAGE="http://vdr.schmirler.de/"
SRC_URI="http://vdr.schmirler.de/epgsync/${P}.tgz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"
IUSE=""

PATCHES=("${FILESDIR}/${PN}-0.0.3-Makefile.diff"
		"${FILESDIR}/${PN}-0.0.2-include.patch")

DEPEND=(">=media-video/vdr-1.4.0"
	">=media-plugins/vdr-svdrpservice-0.0.2")
RDEPEND="${DEPEND}"
