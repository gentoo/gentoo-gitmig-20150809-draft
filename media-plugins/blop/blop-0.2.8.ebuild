# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/blop/blop-0.2.8.ebuild,v 1.4 2004/07/26 07:39:57 eradicator Exp $

IUSE=""
DESCRIPTION="Bandlimited LADSPA Oscillator Plugins"
SRC_URI="mirror://sourceforge/blop/${P}.tar.gz"
HOMEPAGE="http://blop.sf.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 amd64 ~ppc"

DEPEND=">=media-libs/ladspa-sdk-1.12"

src_compile() {
	econf --with-ladspa-prefix=/usr || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYING ChangeLog NEWS THANKS TODO
}
