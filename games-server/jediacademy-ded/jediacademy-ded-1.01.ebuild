# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-server/jediacademy-ded/jediacademy-ded-1.01.ebuild,v 1.2 2004/02/20 07:31:48 mr_bones_ Exp $

inherit games eutils

DESCRIPTION="Jedi Academy Linux Dedicated Server"
HOMEPAGE="http://www.lucasarts.com/products/jediacademy/"
SRC_URI="jalinuxded_1.0.zip"

LICENSE="jedioutcast-ded"
SLOT="0"
KEYWORDS="x86"
RESTRICT="fetch"

S=${WORKDIR}

pkg_nofetch() {
	einfo "Please download ${A} from"
	einfo "http://www.filefront.com/r.b/page__file_info/_filepath__/pub2/Jedi_Knight_Jedi_Academy/Official_Files/Servers/jalinuxded_1.0.zip/_clear__page,filepath/_output.html"
	einfo "and put into ${DISTDIR}"
}

src_unpack() {
	unpack ${A}
	edos2unix readme.txt "server options.txt" server.cfg
	rm "Disclaimer-Jedi Academy Dedicated Server.rtf"
	chmod go-w *
	chmod a+x jampgamei386.so libcxa.so.1 linuxjampded
	mkdir base
	mv server.cfg base/jampserver.cfg
	mv jampgamei386.so base/
}

src_install() {
	local dir=${GAMES_PREFIX_OPT}/${PN}
	dodir ${dir}
	cp -r * ${D}/${dir}/
	dogamesbin ${FILESDIR}/jampded
	dosed "s:GENTOO_DIR:${dir}:" ${GAMES_BINDIR}/jampded
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	ewarn "NOTE: You must copy over the .pak files from a previously"
	ewarn "      installed and patched windows installation for this"
	ewarn "      to run properly."
}
