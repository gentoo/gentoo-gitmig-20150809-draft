# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/mylink/mylink-0.93.ebuild,v 1.3 2004/02/20 07:38:17 mr_bones_ Exp $

inherit games eutils

DESCRIPTION="a free Uplink clone"
HOMEPAGE="http://home.as-netz.de/gblech/klasse10/misc/mylink/mylink.html"
SRC_URI="http://home.as-netz.de/gblech/klasse10/misc/mylink/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND=">=dev-lang/perl-5.8.0
	>=dev-lang/tk-8.3.4
	dev-perl/perl-tk
	dev-perl/Data-Dumper
	dev-perl/Digest-MD5
	dev-perl/libwww-perl
	dev-perl/frontier-rpc"

S=${WORKDIR}/MyLink

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-path.patch
	sed -i "s:GENTOO_DIR:${GAMES_DATADIR}/${PN}:" MyLinkI18N.pm
	sed -i \
		-e "s,^require[ 	]*\(.*\)[ 	]*;,require \"${GAMES_DATADIR}/${PN}/\1.pm\";," \
		-e "s,contrib/,${GAMES_DATADIR}/${PN}/contrib/,g" \
		-e "s,graphics/,${GAMES_DATADIR}/${PN}/graphics/,g" \
		-e "s,data/,${GAMES_DATADIR}/${PN}/data/,g" \
		-e "s,database\.db,${GAMES_DATADIR}/${PN}/database\.db,g" \
		*.pm *.pl \
		|| die "path fixing failed"
	rm Makefile
}

src_install() {
	local dir=${GAMES_DATADIR}/${PN}
	dodir ${dir}
	cp -r *.pm *.txt database.db data graphics ${D}/${dir}/
	newgamesbin MyLinkd.pl MyLinkd
	newgamesbin MyLinkTk.pl MyLinkTk
	prepgamesdirs
	fperms g+w ${GAMES_DATADIR}/${PN}/database.db
}
