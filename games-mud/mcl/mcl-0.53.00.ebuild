# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-mud/mcl/mcl-0.53.00.ebuild,v 1.4 2004/03/30 11:34:49 aliz Exp $

inherit games gnuconfig

DESCRIPTION="A console MUD client scriptable in Perl and Python"
SRC_URI="http://www.andreasen.org/mcl/dist/${P}-src.tar.gz"
HOMEPAGE="http://www.andreasen.org/mcl/"

LICENSE="GPL-2"
KEYWORDS="x86 ~amd64"
SLOT="0"
IUSE="python perl"

RDEPEND="perl? ( dev-lang/perl )
	python? ( dev-lang/python )"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/${P}-fPIC.patch

	sed -i \
		-e "/MCL_LIBRARY_PATH/ s:/usr/lib/mcl:${GAMES_LIBDIR}/${PN}:" \
			h/mcl.h || die "sed h/mcl.h failed"
}

src_compile() {
	gnuconfig_update || die

	egamesconf `use_enable perl` `use_enable python` || die
	emake || die "emake failed"
}

src_install () {
	make INSTALL_ROOT=${D} install || die "make install failed"
	dodoc \
		doc/{Changes,Chat,Embedded,Examples,Modules,Plugins,README,TODO} || \
			die "dodoc failed"
	dohtml doc/*html || die "dohtml failed"
	prepgamesdirs
}
