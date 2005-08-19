# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gaim-rhythmbox/gaim-rhythmbox-1.0.0.1.ebuild,v 1.6 2005/08/19 13:29:38 gustavoz Exp $

inherit debug

DESCRIPTION="automatically update your Gaim profile with current info from Rhythmbox"
HOMEPAGE="http://gaim-rhythmbox.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

GAIM_API="1.0.0"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"
IUSE=""

DEPEND=">=net-im/gaim-${GAIM_API}
	media-sound/rhythmbox"

src_unpack() {
	unpack ${A}
	sed -i -e 's:--variable=prefix`/lib:--variable=libdir`:' \
		${S}/configure{.ac,} || die "sed failed"
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog INSTALL NEWS README TODO
}
