# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mikmod/mikmod-3.2.2_beta1.ebuild,v 1.4 2012/01/22 01:05:19 mr_bones_ Exp $

EAPI=4

DESCRIPTION="MikMod is a console MOD-Player based on libmikmod"
HOMEPAGE="http://mikmod.raphnet.net"
SRC_URI="http://mikmod.raphnet.net/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~sparc ~x86"
IUSE=""

RDEPEND="media-libs/libmikmod:0"
DEPEND="${RDEPEND}"

DOCS=( AUTHORS NEWS README )

S="${WORKDIR}"/${P/_/-}
