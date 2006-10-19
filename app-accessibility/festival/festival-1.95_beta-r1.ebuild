# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/festival/festival-1.95_beta-r1.ebuild,v 1.9 2006/10/19 14:42:22 kloeri Exp $

inherit eutils toolchain-funcs

DESCRIPTION="Festival Text to Speech engine"
HOMEPAGE="http://www.cstr.ed.ac.uk/"
SITE="http://www.cstr.ed.ac.uk/downloads/${PN}/${PV/_beta//}"
MY_P=${PN}-1.95-beta
SRC_URI="${SITE}/${MY_P}.tar.gz
	${SITE}/speech_tools-1.2.95-beta.tar.gz
	${SITE}/festlex_POSLEX.tar.gz
	${SITE}/festlex_CMU.tar.gz
	${SITE}/festlex_OALD.tar.gz
	${SITE}/festvox_rablpc16k.tar.gz
	${SITE}/festvox_don.tar.gz
	${SITE}/festvox_kallpc16k.tar.gz
	${SITE}/festvox_kedlpc16k.tar.gz
	${SITE}/festvox_cmu_us_bdl_arctic_hts.tar.gz
	${SITE}/festvox_cmu_us_slt_arctic_hts.tar.gz
	${SITE}/festvox_cmu_us_jmk_arctic_hts.tar.gz
	${SITE}/festvox_cmu_us_awb_arctic_hts.tar.gz
	linguas_es? ( ${SITE}/festvox_ellpc11k.tar.gz )
	mbrola? (
		${SITE}/festvox_en1.tar.gz
		${SITE}/festvox_us1.tar.gz
		${SITE}/festvox_us2.tar.gz
		${SITE}/festvox_us3.tar.gz )"
LICENSE="FESTIVAL BSD as-is"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86"
IUSE="asterisk esd linguas_es mbrola X"

RDEPEND="sys-libs/ncurses
	esd? ( media-sound/esound )
	mbrola? ( >=app-accessibility/mbrola-3.0.1h-r2 )"

DEPEND="${RDEPEND}
	X? (
			x11-libs/libX11
			x11-libs/libXt )
	sys-apps/sed"

S=${WORKDIR}

src_unpack() {
	unpack ${A}

	use asterisk && epatch ${FILESDIR}/${P}-asterisk.patch
	use esd && sed -i -e 's/# \(INCLUDE_MODULES += ESD_AUDIO\)/\1/' ${S}/speech_tools/config/config.in
	use X || sed -i -e 's/-lX11 -lXt//' ${S}/speech_tools/config/modules/esd_audio.mak

	# testsuite still fails to build under gcc-3.2
	# sed -i '/^BUILD_DIRS =/s/testsuite//' ${S}/Makefile || die

	sed -i -e "/^const char \*festival_libdir/s:FTLIBDIR:\"/usr/share/festival\":" ${S}/festival/src/arch/festival/festival.cc
	sed -i -e '/^MODULE_LIBS/s/-ltermcap/-lncurses/' ${S}/festival/config/modules/editline.mak || die

	# Fix hardcoded path for examples that will be finally installed in /usr/$(get_libdir)/festival/examples
	sed -i -e "s:\.\./examples/:/usr/share/doc/${PF}/examples/:" ${S}/festival/lib/festival.scm

	# gcc 4.1 compatibility patches
	epatch ${FILESDIR}/${P}-gcc41.patch
	epatch ${FILESDIR}/${P}-gcc41-amd64.patch
	epatch ${FILESDIR}/${P}-gcc41-amd64-int-pointer.patch

	epatch ${FILESDIR}/${P}-init-scm.patch
}

src_compile() {
	cd ${S}/speech_tools
	econf || die
	emake -j1 OPTIMISE_CXXFLAGS="${CXXFLAGS}" OPTIMISE_CCFLAGS="${CFLAGS}" CC="$(tc-getCC)" CXX="$(tc-getCXX)" || die
	cd ${S}/festival
	econf || die
	emake -j1 PROJECT_LIBDEPS="" REQUIRED_LIBDEPS="" LOCAL_LIBDEPS="" OPTIMISE_CXXFLAGS="${CXXFLAGS}" OPTIMISE_CCFLAGS="${CFLAGS}" CC="$(tc-getCC)" CXX="$(tc-getCXX)" || die
}

src_install() {
	# Install the binaries
	dobin ${S}/festival/src/main/festival
	dobin ${S}/festival/lib/etc/*Linux*/audsp

	# Install the main libraries
	insinto /usr/share/festival
	doins ${S}/festival/lib/*

	# Install the examples
	insinto /usr/share/doc/${PF}/examples/
	doins -r ${S}/festival/examples/*

	# Need to fix saytime, etc. to look for festival in the correct spot
	for ex in ${D}/usr/share/doc/${PF}/examples/*.sh; do
		exnoext=${ex%%.sh}
		chmod a+x ${exnoext}
		dosed "s:${S}/festival/bin/festival:/usr/bin/festival:" ${exnoext##$D}
	done

	# Install the header files
	insinto /usr/include/festival
	doins ${S}/festival/src/include/*.h

	# Install the dicts
	insinto /usr/share/festival/dicts
	doins -r ${S}/festival/lib/dicts/*

	# Installs all existing voices, no matter what language.
	insinto /usr/share/festival/voices
	doins -r ${S}/festival/lib/voices/*

	insinto /etc/festival
	# Sample server.scm configuration for the server
	doins ${FILESDIR}/server.scm
	doins ${S}/festival/lib/site*

	# Install the init script
	exeinto /etc/init.d
	newexe ${FILESDIR}/festival.rc festival

	use mbrola && mbrola_voices

	# Install the docs
	dodoc ${S}/festival/{ACKNOWLEDGMENTS,NEWS,README}
	doman ${S}/festival/doc/{festival.1,festival_client.1}
}

pkg_postinst() {
	einfo
	elog "    Useful examples include saytime, text2wave. For example, try:"
	elog "        \"/usr/share/doc/${PF}/examples/saytime\""
	einfo
	elog "    Or for something more fun:"
	elog '        "echo "Gentoo can speak" | festival --tts"'
	einfo
	elog "    To enable the festival server at boot, run"
	elog "       rc-update add festival default"
	einfo
	elog "    You must setup the server's port, access list, etc in this file:"
	elog "       /etc/festival/server.scm"
	einfo
	elog "This version also allows configuration of site specific"
	elog "initialization in /etc/festival/siteinit.scm and"
	elog "variables in /etc/festival/sitevars.scm."
	einfo
}

# Fix mbrola databases: create symbolic links from festival voices
# directories to MBROLA install dirs.
mbrola_voices() {

	# This is in case there is no mbrola voice for a particular language.
	local shopts=$(shopt -p nullglob)
	shopt -s nullglob

	# This assumes all mbrola voices are named after the voices defined
	# in MBROLA, i.e. if MBROLA contains a voice fr1, then the Festival
	# counterpart should be named fr1_mbrola.
	for language in ${S}/festival/lib/voices/*; do
		for mvoice in ${language}/*_mbrola; do
			voice=${mvoice##*/}
			database=${voice%%_mbrola}
			dosym /opt/mbrola/${database} /usr/share/festival/voices/${language##*/}/${voice}/${database}
		done
	done

	# Restore shopts
	${shopts}
}
