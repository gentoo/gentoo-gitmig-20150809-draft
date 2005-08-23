# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/festival/festival-1.4.3-r3.ebuild,v 1.11 2005/08/23 17:46:12 agriffis Exp $

inherit eutils

DESCRIPTION="Festival Text to Speech engine"
HOMEPAGE="http://www.cstr.ed.ac.uk/"
SITE="http://www.speech.cs.cmu.edu/${PN}/cstr/${PN}/${PV}"
SRC_URI="${SITE}/${P}-release.tar.gz
	${SITE}/festlex_CMU.tar.gz
	${SITE}/festlex_OALD.tar.gz
	${SITE}/festlex_POSLEX.tar.gz
	${SITE}/festvox_don.tar.gz
	${SITE}/festvox_ellpc11k.tar.gz
	${SITE}/festvox_kallpc16k.tar.gz
	${SITE}/festvox_kedlpc16k.tar.gz
	${SITE}/festvox_rablpc16k.tar.gz
	${SITE}/festvox_us1.tar.gz
	${SITE}/festvox_us2.tar.gz
	${SITE}/festvox_us3.tar.gz
	doc? ( ${SITE}/festdoc-1.4.2.tar.gz )"

LICENSE="FESTIVAL BSD as-is"
SLOT="0"
KEYWORDS="~alpha amd64 hppa ia64 ppc ppc64 sparc x86"
IUSE="asterisk doc"

RDEPEND=">=app-accessibility/speech-tools-1.2.3-r2"
DEPEND="${RDEPEND}
	sys-apps/sed"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${P}-release.tar.gz
	unpack festlex_CMU.tar.gz
	unpack festlex_OALD.tar.gz
	unpack festlex_POSLEX.tar.gz
	unpack festvox_don.tar.gz
	unpack festvox_ellpc11k.tar.gz
	unpack festvox_kallpc16k.tar.gz
	unpack festvox_kedlpc16k.tar.gz
	unpack festvox_rablpc16k.tar.gz
	unpack festvox_us1.tar.gz
	unpack festvox_us2.tar.gz
	unpack festvox_us3.tar.gz

	cd ${S}

	use doc && unpack festdoc-1.4.2.tar.gz && mv festdoc-1.4.2 festdoc

	epatch ${FILESDIR}/${PN}-gcc3.3.diff

	use asterisk && epatch ${FILESDIR}/${P}-asterisk.patch

	sed -i "s@EST=\$(TOP)/../speech_tools@EST=/usr/share/speech-tools@" config/config.in

	# testsuite still fails to build under gcc-3.2
	# sed -i '/^BUILD_DIRS =/s/testsuite//' Makefile || die

	sed -i "/^const char \*festival_libdir/s:FTLIBDIR:\"/usr/share/festival\":" src/arch/festival/festival.cc
	sed -i '/^MODULE_LIBS/s/-ltermcap/-lncurses/' config/modules/editline.mak || die
}

src_compile() {
	econf || die
	emake -j1 \
		PROJECT_LIBDEPS="" \
		REQUIRED_LIBDEPS="" \
		LOCAL_LIBDEPS="" \
		OPTIMISE_CXXFLAGS="${CXXFLAGS}" \
		OPTIMISE_CCFLAGS="${CFLAGS}" \
		|| die
}

src_install() {
	# Install the binaries
	cd ${WORKDIR}/festival/src/main
	dobin festival
	cd ${WORKDIR}/festival/examples
	dobin saytime
	cd ${WORKDIR}/festival/bin
	dobin text2wave
	cd ${WORKDIR}/festival/lib/etc/*Linux*
	dobin audsp

	einfo
	einfo "Please ignore errors about skipped directories. They are harmless."
	einfo

	# Install the main libraries
	insinto /usr/share/festival
	doins ${WORKDIR}/festival/lib/*

	# Install the header files
	insinto /usr/include/festival
	doins ${WORKDIR}/festival/src/include/*.h

	# Install the dicts and vioces
	FESTLIB=${WORKDIR}/festival/lib
	DESTLIB=/usr/share/festival
	insinto ${DESTLIB}/dicts
	doins ${FESTLIB}/dicts/COPYING.poslex \
		${FESTLIB}/dicts/wsj.wp39.poslexR ${FESTLIB}/dicts/wsj.wp39.tri.ngrambin
	insinto ${DESTLIB}/dicts/cmu
	doins ${FESTLIB}/dicts/cmu/*
	insinto ${DESTLIB}/dicts/oald
	doins ${FESTLIB}/dicts/oald/*

	FESTLIB=${WORKDIR}/festival/lib/voices/spanish/el_diphone
	DESTLIB=/usr/share/festival/voices/spanish/el_diphone
	insinto ${DESTLIB}/festvox
	doins ${FESTLIB}/festvox/*
	insinto ${DESTLIB}/group
	doins ${FESTLIB}/group/*

	FESTLIB=${WORKDIR}/festival/lib/voices/english
	DESTLIB=/usr/share/festival/voices/english
	insinto ${DESTLIB}/don_diphone
	doins ${FESTLIB}/don_diphone/*
	insinto ${DESTLIB}/don_diphone/festvox
	doins ${FESTLIB}/don_diphone/festvox/*

	insinto ${DESTLIB}/kal_diphone
	doins ${FESTLIB}/kal_diphone/*
	insinto ${DESTLIB}/kal_diphone/festvox
	doins ${FESTLIB}/kal_diphone/festvox/*
	insinto ${DESTLIB}/kal_diphone/group
	doins ${FESTLIB}/kal_diphone/group/*

	insinto ${DESTLIB}/ked_diphone
	doins ${FESTLIB}/ked_diphone/*
	insinto ${DESTLIB}/ked_diphone/festvox
	doins ${FESTLIB}/ked_diphone/festvox/*
	insinto ${DESTLIB}/ked_diphone/group
	doins ${FESTLIB}/ked_diphone/group/*

	insinto ${DESTLIB}/rab_diphone
	doins ${FESTLIB}/rab_diphone/*
	insinto ${DESTLIB}/rab_diphone/festvox
	doins ${FESTLIB}/rab_diphone/festvox/*
	insinto ${DESTLIB}/rab_diphone/group
	doins ${FESTLIB}/rab_diphone/group/*

	insinto ${DESTLIB}/us1_mbrola
	doins ${FESTLIB}/us1_mbrola/*
	insinto ${DESTLIB}/us1_mbrola/festvox
	doins ${FESTLIB}/us1_mbrola/festvox/*

	insinto ${DESTLIB}/us2_mbrola
	doins ${FESTLIB}/us2_mbrola/*
	insinto ${DESTLIB}/us2_mbrola/festvox
	doins ${FESTLIB}/us2_mbrola/festvox/*

	insinto ${DESTLIB}/us3_mbrola
	doins ${FESTLIB}/us3_mbrola/*
	insinto ${DESTLIB}/us3_mbrola/festvox
	doins ${FESTLIB}/us3_mbrola/festvox/*

	# Sample server.scm configuration for the server
	dodir /etc/festival
	insinto /etc/festival
	doins ${FILESDIR}/server.scm

	# Install the init script
	exeinto /etc/init.d
	newexe ${FILESDIR}/festival.rc festival

	# Need to fix saytime to look for festival in the correct spot
	dosed "s:${WORKDIR}/festival/bin/festival:/usr/bin/festival:" /usr/bin/saytime
	dosed "s:${WORKDIR}/festival/bin/festival:/usr/bin/festival:" /usr/bin/text2wave

	# Install the docs
	cd ${S} # needed
	into /usr
	dodoc ACKNOWLEDGMENTS NEWS README
	doman doc/festival.1 doc/festival_client.1

	if use doc; then
		cd ${S}/festdoc/festival/html
		dohtml *.html
		cd ${S}/festdoc/festival
		dodoc festival.ps
		cd ${S}/festdoc/festival/info
		doinfo *
	fi

	# We used to put stuff here, so be safe for now...
	dodir /usr/lib
	dosym ../share/festival /usr/lib/festival
}

pkg_postinst() {
	einfo
	einfo "    To test festival, simply type:"
	einfo '        "saytime"'
	einfo
	einfo "    Or for something more fun:"
	einfo '        "echo "Gentoo can speak" | festival --tts"'
	einfo
	einfo "    To enable the festival server at boot, run"
	einfo "       rc-update add festival default"
	einfo
	einfo "    You must setup the server's port, access list, etc in this file:"
	einfo "       /etc/festival/server.scm"
	einfo
	einfo "    Emerge mbrola to enable some additional voices."
	einfo
}
