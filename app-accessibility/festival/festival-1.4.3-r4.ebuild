# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/festival/festival-1.4.3-r4.ebuild,v 1.5 2005/08/24 23:13:20 agriffis Exp $

inherit eutils toolchain-funcs

DESCRIPTION="Festival Text to Speech engine"
HOMEPAGE="http://www.cstr.ed.ac.uk/"
SITE="http://www.speech.cs.cmu.edu/${PN}/cstr/${PN}/${PV}"
SRC_URI="${SITE}/${P}-release.tar.gz
	${SITE}/festlex_CMU.tar.gz
	${SITE}/festlex_OALD.tar.gz
	${SITE}/festlex_POSLEX.tar.gz
	${SITE}/festvox_don.tar.gz
	${SITE}/festvox_kallpc16k.tar.gz
	${SITE}/festvox_kedlpc16k.tar.gz
	${SITE}/festvox_rablpc16k.tar.gz
	linguas_es? ( ${SITE}/festvox_ellpc11k.tar.gz )
	doc? ( ${SITE}/festdoc-1.4.2.tar.gz )
	mbrola? (
		${SITE}/festvox_us1.tar.gz
		${SITE}/festvox_us2.tar.gz
		${SITE}/festvox_us3.tar.gz )"

LICENSE="FESTIVAL BSD as-is"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="asterisk doc mbrola"

RDEPEND=">=app-accessibility/speech-tools-1.2.3-r2
	mbrola? ( >=app-accessibility/mbrola-3.0.1h-r2 )"

DEPEND="${RDEPEND}
	sys-apps/findutils
	sys-apps/sed"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}

	use doc && mv festdoc-1.4.2 festdoc

	epatch ${FILESDIR}/${PN}-gcc3.3.diff

	use asterisk && epatch ${FILESDIR}/${P}-asterisk.patch

	sed -i -e "s@EST=\$(TOP)/../speech_tools@EST=/usr/share/speech-tools@" ${S}/config/config.in

	# testsuite still fails to build under gcc-3.2
	# sed -i '/^BUILD_DIRS =/s/testsuite//' ${S}/Makefile || die

	sed -i -e "/^const char \*festival_libdir/s:FTLIBDIR:\"/usr/share/festival\":" ${S}/src/arch/festival/festival.cc
	sed -i -e '/^MODULE_LIBS/s/-ltermcap/-lncurses/' ${S}/config/modules/editline.mak || die

	# Fix hardcoded path for examples that will be finally installed in /usr/$(get_libdir)/festival/examples
	sed -i -e "s:\.\./examples/:/usr/share/doc/${PF}/examples/:" ${S}/lib/festival.scm
}

src_compile() {
	econf || die
	emake -j1 PROJECT_LIBDEPS="" REQUIRED_LIBDEPS="" LOCAL_LIBDEPS="" OPTIMISE_CXXFLAGS="${CXXFLAGS}" OPTIMISE_CCFLAGS="${CFLAGS}" CC="$(tc-getCC)" CXX="$(tc-getCXX)" || die
}

src_install() {
	# Install the binaries
	dobin ${S}/src/main/festival
	dobin ${S}/lib/etc/*Linux*/audsp

	# Install the main libraries
	insinto /usr/share/festival
	doins ${S}/lib/*

	# Install the examples
	insinto /usr/share/doc/${PF}/examples/
	doins -r ${S}/examples/*

	# Need to fix saytime, etc. to look for festival in the correct spot
	for ex in ${D}/usr/share/doc/${PF}/examples/*.sh; do
		exnoext=${ex%%.sh}
		chmod a+x ${exnoext}
		dosed "s:${S}/bin/festival:/usr/bin/festival:" ${exnoext##$D}
	done

	# Install the header files
	insinto /usr/include/festival
	doins ${S}/src/include/*.h

	# Install the dicts
	insinto /usr/share/festival/dicts
	doins -r ${S}/lib/dicts/*

	# Installs all existing voices, no matter what language.
	insinto /usr/share/festival/voices
	doins -r ${S}/lib/voices/*

	# Sample server.scm configuration for the server
	insinto /etc/festival
	doins ${FILESDIR}/server.scm

	# Install the init script
	exeinto /etc/init.d
	newexe ${FILESDIR}/festival.rc festival

	use mbrola && mbrola_voices

	# Install the docs
	dodoc ${S}/{ACKNOWLEDGMENTS,NEWS,README}
	doman ${S}/doc/{festival.1,festival_client.1}

	if use doc; then
		dohtml ${WORKDIR}/festdoc/festival/html/*.html
		dodoc ${WORKDIR}/festdoc/festival/festival.ps
		doinfo ${WORKDIR}/festdoc/festival/info/*
	fi
}

pkg_postinst() {
	einfo
	einfo "    Useful examples include saytime, text2wave. For example, try:"
	einfo "        \"/usr/share/doc/${PF}/examples/saytime\""
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
}

# This is because Portage will not remove links from Festival to MBROLA
# databases: as long as the target of a link exists, the link cannot be
# removed by Portage.
# So we do it by hand here...
pkg_prerm() {
	find /usr/share/festival/voices -type l -path "*_mbrola*" -exec rm -f {} \;
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
	for language in ${S}/lib/voices/*; do
		for mvoice in ${language}/*_mbrola; do
			voice=${mvoice##*/}
			database=${voice%%_mbrola}
			dosym /opt/mbrola/${database} /usr/share/festival/voices/${language##*/}/${voice}/${database}
		done
	done

	# Restore shopts
	${shopts}
}
