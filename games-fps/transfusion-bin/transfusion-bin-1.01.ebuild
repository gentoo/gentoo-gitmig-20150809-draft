# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/transfusion-bin/transfusion-bin-1.01.ebuild,v 1.8 2005/02/26 04:16:50 mr_bones_ Exp $

inherit games

MY_PN=${PN/-bin/}
DESCRIPTION="Blood remake"
HOMEPAGE="http://www.transfusion-game.com/"
SRC_URI="mirror://sourceforge/blood/${MY_PN}-1.0-linux.i386.zip
	mirror://sourceforge/blood/${MY_PN}-patch-${PV}-linux.i386.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* x86"
IUSE=""
RESTRICT="nostrip"

RDEPEND="virtual/libc"
DEPEND="${RDEPEND}
	app-arch/unzip
	>=sys-apps/sed-4"

S="${WORKDIR}/${MY_PN}"

src_install() {
	local dir=${GAMES_PREFIX_OPT}/${MY_PN}

	dodir ${dir}

	# install everything that looks anything like docs...
	dodoc ${MY_PN}/doc/*.txt ${MY_PN}/*txt qw/*txt
	dohtml ${MY_PN}/doc/*.html

	#...then mass copy everything to the install dir...
	cp -R * ${D}/${dir}/

	# ...and remove the docs since we don't need them installed twice.
	rm -rf \
		${D}/${dir}/${MY_PN}/doc \
		${D}/${dir}/qw/*txt \
		${D}/${dir}/${MY_PN}/*txt

	# install the wrapper...
	dogamesbin ${FILESDIR}/transfusion
	# ...and make it cd to the right place.
	sed -i \
		-e "s:GENTOO_DIR:${dir}:" ${D}/${GAMES_BINDIR}/transfusion \
			|| die "sed transfusion failed"

	prepgamesdirs
}
