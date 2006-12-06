# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-util/showeq/showeq-5.2.4.0.ebuild,v 1.6 2006/12/06 21:16:13 wolf31o2 Exp $

inherit kde games

DESCRIPTION="A Everquest monitoring program"
HOMEPAGE="http://seq.sourceforge.net/"
SRC_URI="mirror://sourceforge/seq/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="x11-libs/libXt
	media-libs/libpng
	virtual/libpcap
	$(qt_min_version 3.2)
	>=sys-libs/gdbm-1.8.0"

PATCHES="${FILESDIR}/${P}"-gcc4.patch

src_compile() {
	kde_src_compile nothing
	egamesconf || die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	doman showeq.1
	dodoc BUGS FAQ README* ROADMAP TODO doc/*.{doc,txt}
	dohtml doc/*
	prepgamesdirs
}
