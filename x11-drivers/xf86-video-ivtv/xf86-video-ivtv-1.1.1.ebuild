# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-drivers/xf86-video-ivtv/xf86-video-ivtv-1.1.1.ebuild,v 1.3 2010/10/18 09:39:46 scarabeus Exp $

EAPI=3
inherit xorg-2

DESCRIPTION="X.Org driver for TV-out on ivtvdev cards"
HOMEPAGE="http://ivtvdriver.org/"
SRC_URI="http://dl.ivtvdriver.org/${PN}/${P}.tar.gz"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="x11-base/xorg-server
	x11-libs/libpciaccess
	x11-proto/xextproto
	x11-proto/randrproto
	x11-proto/renderproto
	x11-proto/videoproto"
RDEPEND="${DEPEND}"
