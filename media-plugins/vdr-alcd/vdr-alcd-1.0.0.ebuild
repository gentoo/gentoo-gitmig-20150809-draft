# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-alcd/vdr-alcd-1.0.0.ebuild,v 1.1 2006/05/15 09:19:32 zzam Exp $

IUSE=""
inherit vdr-plugin

DESCRIPTION="VDR plugin: Control Activy 300 LCD"
HOMEPAGE="http://www.htpc-forum.de"
SRC_URI="http://www.htpc-forum.de/download/${P}.tgz"

KEYWORDS="~x86"
SLOT="0"
LICENSE="GPL-2"

DEPEND=">=media-video/vdr-1.2.6"
