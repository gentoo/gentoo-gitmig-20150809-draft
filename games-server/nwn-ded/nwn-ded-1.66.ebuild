# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-server/nwn-ded/nwn-ded-1.66.ebuild,v 1.6 2009/08/23 02:02:03 williamh Exp $

inherit games

DIALOG_URL_BASE=http://files.bioware.com/neverwinternights/dialog/

DESCRIPTION="Neverwinter Nights Dedicated server"
HOMEPAGE="http://nwn.bioware.com/downloads/standaloneserver.html"
SRC_URI="http://content.bioware.com/neverwinternights/patch/NWNDedicatedServer${PV}.zip
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
RESTRICT="mirror"

DEPEND="app-arch/unzip"
RDEPEND="x86? ( ~virtual/libstdc++-3.3 )
	amd64? ( app-emulation/emul-linux-x86-baselibs
		app-emulation/emul-linux-x86-compat )"

S="${WORKDIR}"

src_unpack() {
	unpack NWNDedicatedServer${PV}.zip
	tar -zxf linuxdedserver166.tar.gz || die "unpack linuxdedserver"
	rm -f *dedserver*.{tar.gz,sit,zip}
	rm -f *.exe *.dll

#	unpack linuxserverupdate1xxto166.tar.gz
	declare -a Aarray=(${A})
	unpack ${Aarray[1]}
}

src_install() {
	local dir=${GAMES_PREFIX_OPT}/${PN}
	dodir ${dir}

	mv "${S}"/* "${D}/${dir}"/ || die "installing server"
	games_make_wrapper nwserver ./nwserver "${dir}" "${dir}"

	prepgamesdirs
	chmod -R g+w "${D}/${dir}"
}
