# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-vcd/vdr-vcd-0.8.ebuild,v 1.1 2007/12/16 13:43:58 hd_brummy Exp $

inherit eutils vdr-plugin

DESCRIPTION="VDR plugin: play video cds"

HOMEPAGE="http://www.heiligenmann.de/"
SRC_URI=" http://www.heiligenmann.de/vdr/download/${P}.tgz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=">=media-video/vdr-1.3.18"
