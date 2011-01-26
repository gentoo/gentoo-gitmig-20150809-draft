# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-dvd/vdr-dvd-0.3.7_pre20090106.ebuild,v 1.2 2011/01/26 15:12:30 hd_brummy Exp $

EAPI="3"

inherit vdr-plugin

MY_P="${PN}-cvs-${PV#*_pre}"
S="${WORKDIR}/${MY_P#vdr-}"

DESCRIPTION="VDR Plugin: DVD-Player"
HOMEPAGE="http://sourceforge.net/projects/dvdplugin"
SRC_URI="mirror://gentoo/${MY_P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=media-video/vdr-1.6.0
		>=media-libs/libdvdnav-4.1.2
		>=media-libs/a52dec-0.7.4"
RDEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}/${P}-compile_warnings.diff" )
