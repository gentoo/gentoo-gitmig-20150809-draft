# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mikmod/mikmod-3.2.2.ebuild,v 1.2 2012/12/02 14:38:35 ago Exp $

EAPI=5

DESCRIPTION="A console MOD-Player based on libmikmod"
HOMEPAGE="http://mikmod.shlomifish.org/"
SRC_URI="http://mikmod.shlomifish.org/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~hppa ~ppc ~sparc ~x86"
IUSE=""

RDEPEND=">=media-libs/libmikmod-3.2.0
	>=sys-libs/ncurses-5.7-r7"
DEPEND="${RDEPEND}"

DOCS="AUTHORS NEWS README"
