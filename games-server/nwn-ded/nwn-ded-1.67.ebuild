# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-server/nwn-ded/nwn-ded-1.67.ebuild,v 1.2 2006/07/16 16:18:53 wolf31o2 Exp $

inherit games

#http://files.bioware.com/neverwinternights/updates/linux/167/linuxdedserver167.tar.gz

DIALOG_URL_BASE=http://nwdownloads.bioware.com/neverwinternights/patch/dialog/

DESCRIPTION="Neverwinter Nights Dedicated server"
HOMEPAGE="http://nwn.bioware.com/downloads/standaloneserver.html"
SRC_URI="http://files.bioware.com/neverwinternights/updates/windows/server/NWNDedicatedServer${PV}.zip
	linguas_fr? ( ${DIALOG_URL_BASE}/french/NWNFrench${PV}dialog.zip )
	linguas_de? ( ${DIALOG_URL_BASE}/german/NWNGerman${PV}dialog.zip )
	linguas_it? ( ${DIALOG_URL_BASE}/italian/NWNItalian${PV}dialog.zip )
	linguas_es? ( ${DIALOG_URL_BASE}/spanish/NWNSpanish${PV}dialog.zip )
	!linguas_de? ( !linguas_fr? ( !linguas_es? ( !linguas_it? (
		${DIALOG_URL_BASE}/english/NWNEnglish${PV}dialog.zip
	) ) ) )"

LICENSE="NWN-EULA"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
IUSE=""
RESTRICT="mirror"

DEPEND="app-arch/unzip"
RDEPEND="x86? (
	|| (
		=sys-devel/gcc-3.3*
		sys-libs/libstdc++-v3 ) )
	amd64? ( app-emulation/emul-linux-x86-baselibs
		app-emulation/emul-linux-x86-compat )"

S="${WORKDIR}"

src_unpack() {
	unpack NWNDedicatedServer${PV}.zip
	tar -zxf linuxdedserver${PV/./}.tar.gz || die "unpack linuxdedserver"
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
