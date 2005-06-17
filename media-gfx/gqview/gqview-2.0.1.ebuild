# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/gqview/gqview-2.0.1.ebuild,v 1.5 2005/06/17 20:10:05 hansmi Exp $

DESCRIPTION="A GTK-based image browser"
HOMEPAGE="http://gqview.sourceforge.net/"
SRC_URI="mirror://sourceforge/gqview/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha ~amd64 ia64 ppc ~ppc64 sparc x86"
IUSE=""

DEPEND=">=x11-libs/gtk+-2.4.0
	nls? ( sys-devel/gettext )"

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	# leave README uncompressed because the program reads it
	dodoc AUTHORS ChangeLog TODO
	rm -f "${D}/usr/share/doc/${PF}/COPYING"
}
