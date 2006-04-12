# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-cdda/vdr-cdda-0.1.0-r1.ebuild,v 1.1 2006/04/12 20:12:58 zzam Exp $

inherit vdr-plugin

DESCRIPTION="Video Disk Recorder - CD Digital Audio"
HOMEPAGE="http://www.wahnadium.org/vdr-cdda"
SRC_URI="ftp://ftp.wahnadium.org/pub/vdr-cdda/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=">=media-video/vdr-1.3.22
	>=dev-libs/libcdio-0.75
	"

PATCHES="${FILESDIR}/${P}.patch ${FILESDIR}/${P}-cdspeed.diff"


