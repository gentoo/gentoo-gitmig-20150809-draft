# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/sword-modules/sword-modules-20040406.ebuild,v 1.1 2004/04/07 02:20:47 squinky86 Exp $

DESCRIPTION="a collection of modules for the sword project"
HOMEPAGE="http://www.crosswire.org/sword/"
SRC_URI="http://www.crosswire.org/ftpmirror/pub/sword/modules/raw/KJV.zip
http://www.crosswire.org/ftpmirror/pub/sword/modules/raw/StrongsGreek.zip
http://www.crosswire.org/ftpmirror/pub/sword/modules/raw/StrongsHebrew.zip
http://www.crosswire.org/ftpmirror/pub/sword/modules/raw/ASV.zip
http://www.crosswire.org/ftpmirror/pub/sword/modules/raw/RSV.zip
http://www.crosswire.org/ftpmirror/pub/sword/modules/raw/AKJV.zip
http://www.crosswire.org/ftpmirror/pub/sword/modules/raw/ISBE.zip
http://www.crosswire.org/ftpmirror/pub/sword/modules/raw/ISV.zip
http://www.crosswire.org/ftpmirror/pub/sword/modules/raw/WebstersDict.zip
http://www.crosswire.org/ftpmirror/pub/sword/modules/raw/KJVD.zip
http://www.crosswire.org/ftpmirror/pub/sword/modules/raw/Tyndale.zip
http://www.crosswire.org/ftpmirror/pub/sword/modules/raw/Wycliffe.zip
http://www.crosswire.org/ftpmirror/pub/sword/modules/raw/YLT.zip
http://www.crosswire.org/ftpmirror/pub/sword/modules/raw/Vulgate.zip
http://www.crosswire.org/ftpmirror/pub/sword/modules/raw/Josephus.zip
offensive? (http://www.crosswire.org/ftpmirror/pub/sword/betamodules/raw/BoM.zip
	http://www.crosswire.org/ftpmirror/pub/sword/betamodules/raw/Jasher.zip
	http://www.crosswire.org/ftpmirror/pub/sword/betamodules/win/Quran.zip
	http://www.crosswire.org/ftpmirror/pub/sword/betamodules/win/QuranShakir.zip)"

LICENSE="freedist"
SLOT="0"
KEYWORDS="~x86"
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
unpack Tyndale.zip > /dev/null
unpack Wycliffe.zip > /dev/null
unpack YLT.zip > /dev/null
unpack Vulgate.zip > /dev/null
unpack Josephus.zip > /dev/null

if [ "`use offensive`" ]; then
	unpack BoM.zip > /dev/null
	unpack Jasher.zip > /dev/null
	# uh oh, the quran is only availabe for windows; extract the data
	unpack Quran.zip > /dev/null
	unzip ${S}/data.zip > /dev/null
	unpack QuranShakir.zip > /dev/null
	unzip ${S}/data.zip > /dev/null
fi
}

src_compile() {
	einfo "Nothing to compile."
}

src_install () {
	dodir /usr/share/sword/modules
	cp -a ${S}/modules/* ${D}/usr/share/sword/modules/
	dodir /usr/share/sword/mods.d

	# there are windows-only modules in the offensive flag that put
	# config files into /newmods instead of /mods.d
	use offensive && cp ${S}/newmods/* ${D}/usr/share/sword/mods.d/

	cp ${S}/mods.d/* ${D}/usr/share/sword/mods.d/
}

pkg_postinst() {
	echo
	einfo "You should now have modules for The SWORD Project."
	einfo "You can download more modules from the SWORD homepage:"
	einfo "  http://www.crosswire.org/sword/"
	use offensive || {
		echo
		einfo "You do not have the offensive USE flag enabled."
		einfo "Questionable texts were not installed. To install them,"
		einfo "USE=\"offensive\" emerge sword-modules"
		echo
	}
}
