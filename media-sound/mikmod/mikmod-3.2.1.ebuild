# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mikmod/mikmod-3.2.1.ebuild,v 1.10 2009/08/03 12:54:00 ssuominen Exp $

DESCRIPTION="MikMod is a console MOD-Player based on libmikmod"
HOMEPAGE="http://mikmod.raphnet.net/"
SRC_URI="http://mikmod.raphnet.net/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc sparc x86"
IUSE=""

RDEPEND=">=media-libs/libmikmod-3.1.5"
DEPEND="${RDEPEND}"

src_install () {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc README NEWS
}
