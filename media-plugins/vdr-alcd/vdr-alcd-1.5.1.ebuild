# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-alcd/vdr-alcd-1.5.1.ebuild,v 1.2 2011/01/17 22:55:52 hd_brummy Exp $

EAPI="2"

inherit vdr-plugin

DESCRIPTION="VDR plugin: Control Activy 300 LCD"
HOMEPAGE="http://www.htpc-forum.de"
SRC_URI="http://www.htpc-forum.de/download/${P}.tgz"

KEYWORDS="~x86 ~amd64"
SLOT="0"
LICENSE="GPL-2"
IUSE=""

DEPEND=">=media-video/vdr-1.6.0"
RDEPEND="${DEPEND}"

PATCHES=("${FILESDIR}/${P}-makefile-cleanup.diff"
	"${FILESDIR}/${P}-gcc-4.4.diff")
