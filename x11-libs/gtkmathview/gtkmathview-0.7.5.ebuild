# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/gtkmathview/gtkmathview-0.7.5.ebuild,v 1.2 2005/10/30 02:17:17 joem Exp $

DESCRIPTION="Rendering engine for MathML documents"
HOMEPAGE="http://helm.cs.unibo.it/mml-widget/"
SRC_URI="http://helm.cs.unibo.it/mml-widget/sources/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE="gtk t1lib"

RDEPEND="gtk? ( >=x11-libs/gtk+-2.2.1 )
	>=dev-libs/libxml2-2.6.7
	>=dev-libs/gmetadom-0.1.8
	>=dev-libs/glib-2.2.1
	t1lib? ( >=media-libs/t1lib-5 )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_compile() {
	econf $(use_enable t1lib) \
			$(use_enable gtk) || die
	emake || die
}

src_install() {

	make install DESTDIR="${D}" || die

	dodoc ANNOUNCEMENT AUTHORS BUGS CONTRIBUTORS ChangeLog HISTORY INSTALL NEWS README TODO
}
