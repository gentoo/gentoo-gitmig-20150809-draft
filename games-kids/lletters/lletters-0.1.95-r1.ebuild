# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-kids/lletters/lletters-0.1.95-r1.ebuild,v 1.15 2006/10/04 18:35:18 nyhm Exp $

inherit eutils games

DESCRIPTION="Game that helps young kids learn their letters and numbers"
HOMEPAGE="http://lln.sourceforge.net/"
SRC_URI="mirror://sourceforge/lln/${PN}-media-0.1.9a.tar.gz
	mirror://sourceforge/lln/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="nls"

RDEPEND="media-libs/imlib
	=x11-libs/gtk+-1.2*
	nls? ( virtual/libintl )"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${P}.tar.gz
	cd "${S}"
	cp -f "${FILESDIR}"/tellhow.h.gentoo tellhow.h || die "cp failed"
	unpack lletters-media-0.1.9a.tar.gz
	epatch "${FILESDIR}"/${P}-build.patch
	sed -i 's:$(gnulocaledir):/usr/share/locale:' \
		$(find . -name 'Makefile.in*') \
		|| die "sed failed"
}

src_compile() {
	egamesconf \
		$(use_enable nls) \
		|| die
	emake -C libqdwav || die "emake failed"
	emake || die "emake failed"
}

src_install () {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS CREDITS ChangeLog README* TODO
	prepgamesdirs
}
