# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-server/nwn-ded/nwn-ded-1.65-r1.ebuild,v 1.2 2005/06/28 09:08:29 blubb Exp $

inherit games

DIALOG_URL_BASE=http://nwdownloads.bioware.com/neverwinternights/patch/dialog/

DESCRIPTION="Neverwinter Nights Dedicated server"
HOMEPAGE="http://nwn.bioware.com/downloads/standaloneserver.html"
SRC_URI="http://nwdownloads.bioware.com/neverwinternights/standaloneserver/NWNDedicatedServer1.64.zip
	http://content.bioware.com/neverwinternights/linux/165/linuxserverupdate1xxto165.tar.gz
	linguas_fr? ( ${DIALOG_URL_BASE}/french/NWNFrench${PV}dialog.zip )
	linguas_de? ( ${DIALOG_URL_BASE}/german/NWNGerman${PV}dialog.zip )
	linguas_it? ( ${DIALOG_URL_BASE}/italian/NWNItalian${PV}dialog.zip )
	linguas_es? ( ${DIALOG_URL_BASE}/spanish/NWNSpanish${PV}dialog.zip )
	!linguas_de? ( !linguas_fr? ( !linguas_es? ( !linguas_it? (
		${DIALOG_URL_BASE}/english/NWNEnglish${PV}dialog.zip
	) ) ) )"

LICENSE="NWN-EULA"
SLOT="0"
KEYWORDS="-* ~amd64 x86"
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
	declare -a Aarray=(${A})
	unpack ${Aarray[2]}
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
