# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/gqview/gqview-1.5.4.ebuild,v 1.3 2005/05/09 00:28:44 agriffis Exp $

DESCRIPTION="A GTK-based image browser"
HOMEPAGE="http://gqview.sourceforge.net/"
SRC_URI="mirror://sourceforge/gqview/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ia64 ppc ~ppc64 ~sparc ~x86"
IUSE="nls xinerama"

DEPEND="media-libs/libpng
	>=x11-libs/gtk+-2.2.0"
RDEPEND="nls? ( sys-devel/gettext )"

src_compile() {
	econf \
		--disable-dependency-tracking \
		$(use_enable xinerama) \
		$(use_enable nls) || die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"

	# Don't remove duplicate README, the program looks for it. (bug 30111)
	# rm -rf ${D}/usr/share/gqview
	dodoc AUTHORS ChangeLog README TODO || die "dodoc failed"
}
