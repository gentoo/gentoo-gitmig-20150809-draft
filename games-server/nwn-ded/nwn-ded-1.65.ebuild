# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-server/nwn-ded/nwn-ded-1.65.ebuild,v 1.1 2004/12/30 08:45:11 vapier Exp $

inherit games

DESCRIPTION="Neverwinter Nights Dedicated server"
HOMEPAGE="http://nwn.bioware.com/downloads/standaloneserver.html"
SRC_URI="http://nwdownloads.bioware.com/neverwinternights/standaloneserver/NWNDedicatedServer1.64.zip
	http://content.bioware.com/neverwinternights/linux/165/linuxserverupdate1xxto165.tar.gz
	http://nwdownloads.bioware.com/neverwinternights/patch/dialog/english/NWNEnglish1.65dialog.zip"

LICENSE="NWN-EULA"
SLOT="0"
KEYWORDS="-* x86"
IUSE=""
RESTRICT="nomirror"

DEPEND="app-arch/unzip"
RDEPEND=""

S="${WORKDIR}"

src_unpack() {
	unpack NWNDedicatedServer1.64.zip
	tar -zxf linuxdedserver164.tar.gz || die "unpack linuxdedserver"
	rm -f *dedserver*.{tar.gz,sit}

	unpack linuxserverupdate1xxto165.tar.gz
	unpack NWNEnglish1.65dialog.zip
}

src_install() {
	local dir=${GAMES_PREFIX_OPT}/${PN}
	dodir ${dir}

	mv "${S}"/* "${D}/${dir}"/ || die "installing server"
	dogamesbin "${FILESDIR}"/nwserver
	dosed "s:GENTOO_DIR:${dir}:" "${GAMES_BINDIR}"/nwserver

	prepgamesdirs
	chmod -R g+w "${D}/${dir}"
}
