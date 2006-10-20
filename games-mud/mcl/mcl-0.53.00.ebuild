# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-mud/mcl/mcl-0.53.00.ebuild,v 1.13 2006/10/20 01:11:22 nyhm Exp $

inherit eutils games

DESCRIPTION="A console MUD client scriptable in Perl and Python"
HOMEPAGE="http://www.andreasen.org/mcl/"
SRC_URI="http://www.andreasen.org/mcl/dist/${P}-src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="python perl"

DEPEND="perl? ( dev-lang/perl )
	python? ( dev-lang/python )"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${P}-fPIC.patch"
	epatch "${FILESDIR}/${PV}-vc.patch"
	epatch "${FILESDIR}/${P}-gcc34.patch"
	epatch "${FILESDIR}/${PV}-dynacomplete.patch"

	sed -i \
		-e "/MCL_LIBRARY_PATH/ s:/usr/lib/mcl:${GAMES_LIBDIR}/${PN}:" \
		h/mcl.h \
		|| die "sed h/mcl.h failed"
}

src_compile() {
	egamesconf \
		$(use_enable perl) \
		$(use_enable python) \
		|| die
	emake || die "emake failed"
}

src_install () {
	emake INSTALL_ROOT="${D}" install || die "emake install failed"
	dodoc \
		doc/{Changes,Chat,Embedded,Examples,Modules,Plugins,README,TODO} \
		|| die "dodoc failed"
	dohtml doc/*html || die "dohtml failed"
	prepgamesdirs
}
