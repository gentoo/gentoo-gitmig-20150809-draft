# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/sword-modules/sword-modules-20040503.ebuild,v 1.12 2005/07/27 03:22:09 vanquirius Exp $

DESCRIPTION="a collection of modules for the sword project"
HOMEPAGE="http://www.crosswire.org/sword/"
SRC_URI="http://www.crosswire.org/ftpmirror/pub/sword/packages/rawzip/KJV.zip
	http://www.crosswire.org/ftpmirror/pub/sword/packages/rawzip/StrongsGreek.zip
	http://www.crosswire.org/ftpmirror/pub/sword/packages/rawzip/StrongsHebrew.zip
	http://www.crosswire.org/ftpmirror/pub/sword/packages/rawzip/ASV.zip
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
	intl? ( http://www.crosswire.org/ftpmirror/pub/sword/packages/rawzip/GerElb.zip
		http://www.crosswire.org/ftpmirror/pub/sword/packages/rawzip/GerElb1871.zip
		http://www.crosswire.org/ftpmirror/pub/sword/packages/rawzip/GerLut.zip
		http://www.crosswire.org/ftpmirror/pub/sword/packages/rawzip/GerLut1545.zip
		http://www.crosswire.org/ftpmirror/pub/sword/packages/rawzip/GerSch.zip )"
# must wait for the betamodules to return.
#	http://www.crosswire.org/ftpmirror/pub/sword/betamodules/win/QuranShakir.zip

RESTRICT="nomirror"
LICENSE="freedist"
SLOT="0"
KEYWORDS="x86 ppc amd64"
IUSE="intl"

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

	if use intl; then
		unpack GerElb.zip > /dev/null
		unpack GerElb1871.zip > /dev/null
		unpack GerLut.zip > /dev/null
		unpack GerLut1545.zip > /dev/null
		unpack GerSch.zip > /dev/null
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
}

pkg_postinst() {
	echo
	einfo "You should now have modules for The SWORD Project."
	einfo "You can download more modules from the SWORD homepage:"
	einfo "  http://www.crosswire.org/sword/"
	if ! use intl; then
		echo
		einfo "To enable different languages of selected texts contained"
		einfo "in this ebuild,"
		einfo "USE=\"intl\" emerge ${PN}"
	fi
}
