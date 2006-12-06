# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-util/showeq/showeq-5.3.0.0.ebuild,v 1.3 2006/12/06 21:16:13 wolf31o2 Exp $

inherit kde games

DESCRIPTION="An Everquest monitoring program"
HOMEPAGE="http://www.showeq.net/"
SRC_URI="mirror://sourceforge/seq/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="virtual/libpcap
	$(qt_min_version 3.2)
	>=sys-libs/gdbm-1.8.0"

DEPEND="${RDEPEND}
	x11-libs/libXt"

PATCHES="${FILESDIR}/${P}"-gcc4.patch

src_compile() {
	kde_src_compile nothing
	egamesconf || die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	doman showeq.1
	dodoc AUTHORS BUGS ChangeLog FAQ NEWS README ROADMAP TODO doc/*.{doc,txt}
	dohtml doc/map.html
	prepgamesdirs
}
