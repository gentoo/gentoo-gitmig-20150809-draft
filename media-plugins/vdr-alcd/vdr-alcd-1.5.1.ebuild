# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-alcd/vdr-alcd-1.5.1.ebuild,v 1.1 2009/06/14 08:44:13 zzam Exp $

IUSE=""
inherit vdr-plugin

DESCRIPTION="VDR plugin: Control Activy 300 LCD"
HOMEPAGE="http://www.htpc-forum.de"
SRC_URI="http://www.htpc-forum.de/download/${P}.tgz"

KEYWORDS="~x86"
SLOT="0"
LICENSE="GPL-2"

DEPEND=">=media-video/vdr-1.6.0"
RDEPEND="${DEPEND}"

PATCHES=("${FILESDIR}/${P}-makefile-cleanup.diff"
	"${FILESDIR}/${P}-gcc-4.4.diff")
