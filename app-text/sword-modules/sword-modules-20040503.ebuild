# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/sword-modules/sword-modules-20040503.ebuild,v 1.5 2004/08/18 17:17:46 squinky86 Exp $

DESCRIPTION="a collection of modules for the sword project"
HOMEPAGE="http://www.crosswire.org/sword/"
SRC_URI="http://www.crosswire.org/ftpmirror/pub/sword/packages/rawzip/KJV.zip
http://www.crosswire.org/ftpmirror/pub/sword/packages/rawzip/StrongsGreek.zip
http://www.crosswire.org/ftpmirror/pub/sword/packages/rawzip/StrongsHebrew.zip
http://www.crosswire.org/ftpmirror/pub/sword/packages/rawzip/ASV.zip
http://www.crosswire.org/ftpmirror/pub/sword/packages/rawzip/RSV.zip
http://www.crosswire.org/ftpmirror/pub/sword/packages/rawzip/AKJV.zip
http://www.crosswire.org/ftpmirror/pub/sword/packages/rawzip/ISBE.zip
http://www.crosswire.org/ftpmirror/pub/sword/packages/rawzip/ISV.zip
http://www.crosswire.org/ftpmirror/pub/sword/packages/rawzip/WebstersDict.zip
http://www.crosswire.org/ftpmirror/pub/sword/packages/rawzip/KJVD.zip
http://www.crosswire.org/ftpmirror/pub/sword/packages/rawzip/SME.zip
http://www.crosswire.org/ftpmirror/pub/sword/packages/rawzip/Robinson.zip
http://www.crosswire.org/ftpmirror/pub/sword/packages/rawzip/WEB.zip
http://www.crosswire.org/ftpmirror/pub/sword/packages/rawzip/Packard.zip
http://www.crosswire.org/ftpmirror/pub/sword/packages/rawzip/Vulgate.zip
http://www.crosswire.org/ftpmirror/pub/sword/packages/rawzip/Josephus.zip
offensive? (mirror://gentoo/BoM.zip
	mirror://gentoo/Jasher.zip
	mirror://gentoo/Quran.zip)"
#	http://www.crosswire.org/ftpmirror/pub/sword/betamodules/win/QuranShakir.zip)"
RESTRICT="nomirror"
LICENSE="freedist"
SLOT="0"
KEYWORDS="x86 ~ppc ~amd64"
IUSE="offensive"

S=${WORKDIR}

RDEPEND="app-text/sword"
DEPEND="${RDEPEND}
	app-arch/unzip"

src_unpack() {
	# first, extract the easy ones
	unpack KJV.zip > /dev/null
	unpack StrongsGreek.zip > /dev/null
	unpack StrongsHebrew.zip > /dev/null
	unpack ASV.zip > /dev/null
	unpack RSV.zip > /dev/null
	unpack AKJV.zip > /dev/null
	unpack ISBE.zip > /dev/null
	unpack ISV.zip > /dev/null
	unpack WebstersDict.zip > /dev/null
	unpack KJVD.zip > /dev/null
	unpack SME.zip > /dev/null
	unpack Robinson.zip > /dev/null
	unpack WEB.zip > /dev/null
	unpack Packard.zip > /dev/null
	unpack Vulgate.zip > /dev/null
	unpack Josephus.zip > /dev/null

	if use offensive; then
		unpack BoM.zip > /dev/null
		unpack Jasher.zip > /dev/null
		# uh oh, the quran is only availabe for windows; extract the data
		unpack Quran.zip > /dev/null
		unzip ${S}/data.zip > /dev/null
#		unpack QuranShakir.zip > /dev/null
#		unzip ${S}/data.zip > /dev/null
	fi
}

src_compile() {
	einfo "Nothing to compile."
}

src_install () {
	dodir /usr/share/sword/modules || die
	cp -a ${S}/modules/* ${D}/usr/share/sword/modules/ || die
	dodir /usr/share/sword/mods.d || die
	cp ${S}/mods.d/* ${D}/usr/share/sword/mods.d/ || die

	# there are windows-only modules in the offensive flag that put
	# config files into /newmods instead of /mods.d
	if use offensive; then
		cp ${S}/newmods/* ${D}/usr/share/sword/mods.d/ || die
	fi
}

pkg_postinst() {
	echo
	einfo "You should now have modules for The SWORD Project."
	einfo "You can download more modules from the SWORD homepage:"
	einfo "  http://www.crosswire.org/sword/"
	if ! use offensive; then
		echo
		einfo "You do not have the offensive USE flag enabled."
		einfo "Questionable texts were not installed. To install them,"
		einfo "USE=\"offensive\" emerge sword-modules"
		echo
	fi
}
