# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-server/jedioutcast-ded/jedioutcast-ded-1.04.ebuild,v 1.2 2004/02/20 07:31:48 mr_bones_ Exp $

inherit games eutils

DESCRIPTION="Jedi Outcast Linux Dedicated Server"
HOMEPAGE="http://www.lucasarts.com/products/jediacademy/"
SRC_URI="jk2linuxded104.zip"

LICENSE="jedioutcast-ded"
SLOT="0"
KEYWORDS="x86"
RESTRICT="fetch"

S=${WORKDIR}

pkg_nofetch() {
	einfo "Please download ${A} from"
	einfo "http://www.jk2files.com/file.info?ID=3826"
	einfo "and put into ${DISTDIR}"
}

src_unpack() {
	unpack ${A}
	edos2unix readme.txt "server options.txt" base/server.cfg
	rm "Disclaimer-Jedi Outcast-Linux Dedicated Server Binary.doc"
	chmod a+x jk2ded
	chmod -R og-w *
	mv base/{server,jk2mpserver}.cfg
}

src_install() {
	local dir=${GAMES_PREFIX_OPT}/${PN}
	dodir ${dir}
	cp -r * ${D}/${dir}/
	dogamesbin ${FILESDIR}/jk2ded
	dosed "s:GENTOO_DIR:${dir}:" ${GAMES_BINDIR}/jk2ded
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	ewarn "NOTE: You must copy over the .pak files from a previously"
	ewarn "      installed and patched windows installation for this"
	ewarn "      to run properly."
}
