# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/psindustrializer/psindustrializer-0.2.2.ebuild,v 1.5 2004/07/19 09:47:14 dholm Exp $

DESCRIPTION="Percussion Sample Generator (Discrete Mass Physical Modelling"
HOMEPAGE="http://uts.cc.utexas.edu/~foxx/industrializer/index.html"
SRC_URI="http://uts.cc.utexas.edu/~foxx/industrializer/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc"

IUSE=""

DEPEND="=x11-libs/gtk+-1.2.10* \
	gnome-base/gnome-libs \
	=x11-libs/gtkglarea-1.2.3* \
	media-sound/esound"

src_compile() {
	econf || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc README COPYING INSTALL AUTHORS ABOUT-NLS NEWS TODO ChangeLog
}
