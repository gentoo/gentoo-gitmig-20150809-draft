# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/banshee-official-plugins/banshee-official-plugins-0.11.0.ebuild,v 1.2 2006/09/20 09:33:41 metalgod Exp $

inherit mono

DESCRIPTION="Banshee Official Plugins"
HOMEPAGE="http://www.banshee-project.org/"
SRC_URI="http://banshee-project.org/files/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="media-sound/banshee"

RDEPEND=""

src_compile() {
	econf || die

	emake -j1 || die
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
}
