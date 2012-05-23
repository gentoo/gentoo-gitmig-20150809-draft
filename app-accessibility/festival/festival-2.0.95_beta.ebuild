# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/festival/festival-2.0.95_beta.ebuild,v 1.4 2012/05/23 23:01:52 vapier Exp $

EAPI="2"
inherit eutils toolchain-funcs user

MY_PV=${PV/_beta/-beta}
MY_P=${PN}-${MY_PV}

DESCRIPTION="Festival Text to Speech engine"
HOMEPAGE="http://www.cstr.ed.ac.uk/projects/festival/"
SITE="http://www.festvox.org/packed/${PN}/${MY_PV%-beta}"
SRC_URI="${SITE}/${MY_P}.tar.gz
	${SITE}/festlex_CMU.tar.gz
	${SITE}/festlex_OALD.tar.gz
	${SITE}/festlex_POSLEX.tar.gz
	${SITE}/festvox_cmu_us_awb_cg.tar.gz
	${SITE}/festvox_cmu_us_rms_cg.tar.gz
	${SITE}/festvox_cmu_us_slt_arctic_hts.tar.gz
	${SITE}/festvox_rablpc16k.tar.gz
	${SITE}/festvox_kallpc16k.tar.gz
	${SITE}/speech_tools-${MY_PV}.tar.gz"

LICENSE="FESTIVAL BSD as-is"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="alsa"

SP_DEPEND="~app-accessibility/speech-tools-2.0.95_beta"

DEPEND="${SP_DEPEND}
	alsa? ( media-sound/alsa-utils )"
RDEPEND="${SP_DEPEND}"

S=${WORKDIR}/festival

pkg_setup() {
	enewuser festival -1 -1 -1 audio
}

src_prepare() {
	# tell festival to use the speech-tools we have installed.
	sed -i -e "s:\(EST=\).*:\1/usr/share/speech-tools:" "${S}"/config/config.in
	sed -i -e "s:\$(EST)/lib:/usr/$(get_libdir):" "${S}"/config/project.mak

	# fix the reference  to /usr/lib/festival
	sed -i -e "s:\(FTLIBDIR.*=.*\)\$.*:\1/usr/share/festival:" "${S}"/config/project.mak

	# Fix path for examples in festival.scm
	sed -i -e "s:\.\./examples/:/usr/share/doc/${PF}/examples/:" "${S}"/lib/festival.scm

	epatch "${FILESDIR}/${P}-init-scm.patch"

	# copy what we need for MultiSyn from speech_tools.
	cp -pr "${WORKDIR}"/speech_tools/base_class "${S}"/src/modules/MultiSyn

	if use alsa; then
		echo "(Parameter.set 'Audio_Command \"aplay -q -c 1 -t raw -f s16 -r \$SR \$FILE\")" >> "${S}"/lib/siteinit.scm
		echo "(Parameter.set 'Audio_Method 'Audio_Command)" >> "${S}"/lib/siteinit.scm
	fi
}

src_configure() {
	econf || die "econf failed"
}

src_compile() {
	emake -j1 PROJECT_LIBDEPS="" REQUIRED_LIBDEPS="" LOCAL_LIBDEPS="" \
		OPTIMISE_CXXFLAGS="${CXXFLAGS}" OPTIMISE_CCFLAGS="${CFLAGS}" \
		CC="$(tc-getCC)" CXX="$(tc-getCXX)" || die "emake failed"
}

src_install() {
	# Install the binaries
	dobin src/main/festival
	dobin lib/etc/*Linux*/audsp
	dolib.a src/lib/libFestival.a

	# Install the main libraries
	insinto /usr/share/festival
	doins -r lib/*

	# Install the examples
	insinto /usr/share/doc/${PF}
	doins -r examples

	# Need to fix saytime, etc. to look for festival in the correct spot
	for ex in "${D}"/usr/share/doc/${PF}/examples/*.sh; do
		exnoext=${ex%%.sh}
		chmod a+x "${exnoext}"
		dosed "s:${S}/bin/festival:/usr/bin/festival:" "${exnoext##$D}"
	done

	# Install the header files
	insinto /usr/include/festival
	doins src/include/*.h

	insinto /etc/festival
	# Sample server.scm configuration for the server
	doins "${FILESDIR}"/server.scm
	doins lib/site*

	# Install the init script
	newinitd "${FILESDIR}"/festival.rc festival

	# Install the docs
	dodoc "${S}"/{ACKNOWLEDGMENTS,NEWS,README}
	doman "${S}"/doc/{festival.1,festival_client.1}

	# create the directory where our log file will go.
	diropts -m 0755 -o festival -g audio
	keepdir /var/log/festival

}

pkg_postinst() {
	elog
	elog "    Useful examples include saytime, text2wave. For example, try:"
	elog "        \"/usr/share/doc/${PF}/examples/saytime\""
	elog
	elog "    Or for something more fun:"
	elog '        "echo "Gentoo can speak" | festival --tts"'
	elog
	elog "    To enable the festival server at boot, run"
	elog "       rc-update add festival default"
	elog
	elog "    You must setup the server's port, access list, etc in this file:"
	elog "       /etc/festival/server.scm"
	elog
	elog "This version also allows configuration of site specific"
	elog "initialization in /etc/festival/siteinit.scm and"
	elog "variables in /etc/festival/sitevars.scm."
	elog
}
