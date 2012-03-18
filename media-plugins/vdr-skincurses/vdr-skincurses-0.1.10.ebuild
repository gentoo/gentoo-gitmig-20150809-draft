# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-skincurses/vdr-skincurses-0.1.10.ebuild,v 1.1 2012/03/18 22:44:24 hd_brummy Exp $

EAPI="4"

inherit vdr-plugin

DESCRIPTION="VDR plugin: show content of menu in a shell window"
HOMEPAGE="http://www.tvdr.de/"
SRC_URI="mirror://gentoo/${P}.tar.gz"

KEYWORDS="~x86 ~amd64"
SLOT="0"
LICENSE="GPL-2"
IUSE=""

DEPEND=">=media-video/vdr-1.6.0"
RDEPEND="${DEPEND}"
