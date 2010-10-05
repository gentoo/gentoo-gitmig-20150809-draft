# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-cdda/vdr-cdda-0.1.0-r1.ebuild,v 1.7 2010/10/05 18:03:00 ssuominen Exp $

inherit vdr-plugin

DESCRIPTION="Video Disk Recorder - CD Digital Audio"
HOMEPAGE="http://www.wahnadium.org/vdr-cdda.html"
SRC_URI="ftp://ftp.wahnadium.org/pub/vdr-cdda/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 x86"
IUSE=""

DEPEND=">=media-video/vdr-1.3.22
	>=dev-libs/libcdio-0.75
	"
RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}"/${P}.patch
	"${FILESDIR}"/${P}-cdspeed.diff
	"${FILESDIR}"/${P}-linking-order.diff
	"${FILESDIR}"/${P}_gcc-4.4.patch
	"${FILESDIR}"/${P}-glibc-212.patch
	)
