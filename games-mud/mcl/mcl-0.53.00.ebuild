# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-mud/mcl/mcl-0.53.00.ebuild,v 1.11 2004/12/02 09:27:56 mr_bones_ Exp $

inherit eutils gnuconfig games

DESCRIPTION="A console MUD client scriptable in Perl and Python"
HOMEPAGE="http://www.andreasen.org/mcl/"
SRC_URI="http://www.andreasen.org/mcl/dist/${P}-src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64 ~ppc"
IUSE="python perl"

DEPEND="virtual/libc
	perl? ( dev-lang/perl )
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
	gnuconfig_update
}

src_compile() {
	egamesconf \
		$(use_enable perl) \
		$(use_enable python) \
		|| die
	emake || die "emake failed"
}

src_install () {
	make INSTALL_ROOT="${D}" install || die "make install failed"
	dodoc \
		doc/{Changes,Chat,Embedded,Examples,Modules,Plugins,README,TODO} \
		|| die "dodoc failed"
	dohtml doc/*html || die "dohtml failed"
	prepgamesdirs
}
