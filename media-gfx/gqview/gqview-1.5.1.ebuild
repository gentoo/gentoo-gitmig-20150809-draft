# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/gqview/gqview-1.5.1.ebuild,v 1.1 2004/04/06 16:23:35 avenj Exp $

DESCRIPTION="A GTK-based image browser"
HOMEPAGE="http://gqview.sourceforge.net/"
SRC_URI="mirror://sourceforge/gqview/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~amd64"
IUSE="nls xinerama"

DEPEND="media-libs/libpng
	>=x11-libs/gtk+-2.2.0"

RDEPEND="nls? ( sys-devel/gettext )"

src_compile() {
	econf \
		--disable-dependency-tracking \
		`use_enable xinerama` \
		`use_enable nls` || die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"

	# Don't remove duplicate README, the program looks for it. (bug 30111)
	# rm -rf ${D}/usr/share/gqview
	dodoc AUTHORS ChangeLog README TODO || die "dodoc failed"
}
