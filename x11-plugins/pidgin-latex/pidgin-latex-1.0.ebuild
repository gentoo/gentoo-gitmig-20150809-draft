# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/pidgin-latex/pidgin-latex-1.0.ebuild,v 1.4 2007/08/26 12:38:54 philantrop Exp $

inherit flag-o-matic multilib

DESCRIPTION="Pidgin plugin that renders latex formulae"
HOMEPAGE="http://sourceforge.net/projects/pidgin-latex"
SRC_URI="mirror://sourceforge/pidgin-latex/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

DEPEND="net-im/pidgin"
RDEPEND="virtual/tetex
		media-gfx/imagemagick"

S=${WORKDIR}/${PN}

src_compile()
{
	append-flags -fPIC
	emake || die "emake failed"
}

src_install()
{
	make LIB_INSTALL_DIR="${D}/usr/$(get_libdir)/pidgin" install PREFIX=${D}/usr \
	|| die "make install failed"
	dodoc README CHANGELOG COPYING TODO
}
