# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-mud/mcl/mcl-0.53.00.ebuild,v 1.15 2007/04/09 18:34:31 nyhm Exp $

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

	epatch \
		"${FILESDIR}"/${P}-fPIC.patch \
		"${FILESDIR}"/${PV}-vc.patch \
		"${FILESDIR}"/${P}-gcc34.patch \
		"${FILESDIR}"/${PV}-dynacomplete.patch \
		"${FILESDIR}"/${P}-libdir.patch

	sed -i \
		-e "/MCL_LIBRARY_PATH/ s:/usr/lib/mcl:$(games_get_libdir)/${PN}:" \
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
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc \
		doc/{Changes,Chat,Embedded,Examples,Modules,Plugins,README,TODO} \
		|| die "dodoc failed"
	dohtml doc/*html || die "dohtml failed"
	prepgamesdirs
}
