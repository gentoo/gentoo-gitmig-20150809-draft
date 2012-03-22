# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/csound/csound-5.17.2.ebuild,v 1.1 2012/03/22 01:08:57 radhermit Exp $

EAPI="4"
PYTHON_DEPEND="python? 2"

inherit eutils multilib python java-pkg-opt-2 scons-utils toolchain-funcs versionator

MY_PN="${PN/c/C}"
MY_P="${MY_PN}${PV}"
DOCS_P="${MY_PN}$(get_version_component_range 1-2)"

DESCRIPTION="A sound design and signal processing system providing facilities for composition and performance"
HOMEPAGE="http://csounds.com/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz
	html? (
		linguas_fr? ( mirror://sourceforge/${PN}/${DOCS_P}_manual-fr_html.zip )
		!linguas_fr? ( mirror://sourceforge/${PN}/${DOCS_P}_manual_html.zip )
	)
	doc? (
		linguas_fr? ( mirror://sourceforge/${PN}/${DOCS_P}_manual-fr_pdf.zip )
		!linguas_fr? ( mirror://sourceforge/${PN}/${DOCS_P}_manual_pdf.zip )
	)"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+alsa beats chua csoundac +cxx debug doc double-precision dssi examples fltk +fluidsynth
html +image jack java keyboard linear lua luajit nls osc openmp portaudio portmidi pulseaudio
python samples static-libs stk tcl test +threads +utils vim-syntax vst"

LANGS=" de en_GB en_US es_CO fr it ro ru"
IUSE+="${LANGS// / linguas_}"

RDEPEND=">=media-libs/libsndfile-1.0.16
	alsa? ( media-libs/alsa-lib )
	csoundac? ( x11-libs/fltk:1[threads?]
		dev-libs/boost
		=dev-lang/python-2* )
	dssi? ( media-libs/dssi
		media-libs/ladspa-sdk )
	fluidsynth? ( media-sound/fluidsynth )
	fltk? ( x11-libs/fltk:1[threads?] )
	image? ( media-libs/libpng )
	jack? ( media-sound/jack-audio-connection-kit )
	java? ( >=virtual/jdk-1.5 )
	keyboard? ( x11-libs/fltk:1[threads?] )
	linear? ( sci-mathematics/gmm )
	lua? (
		luajit? ( dev-lang/luajit:2 )
		!luajit? ( dev-lang/lua )
	)
	osc? ( media-libs/liblo )
	portaudio? ( media-libs/portaudio )
	portmidi? ( media-libs/portmidi )
	pulseaudio? ( media-sound/pulseaudio )
	stk? ( media-libs/stk )
	tcl? ( >=dev-lang/tcl-8.5
		>=dev-lang/tk-8.5 )
	utils? ( !media-sound/snd )
	vst? ( x11-libs/fltk:1[threads?]
		dev-libs/boost
		=dev-lang/python-2* )"
DEPEND="${RDEPEND}
	sys-devel/flex
	virtual/yacc
	chua? ( dev-libs/boost )
	csoundac? ( dev-lang/swig )
	html? ( app-arch/unzip )
	doc? ( app-arch/unzip )
	nls? ( sys-devel/gettext )
	test? ( =dev-lang/python-2* )
	vst? ( dev-lang/swig )"

REQUIRED_USE="vst? ( csoundac )
	java? ( cxx )
	linear? ( double-precision )
	lua? ( cxx )
	python? ( cxx )"

S="${WORKDIR}/${MY_P}"

pkg_setup() {
	if use openmp ; then
		tc-has-openmp || die "Please switch to an openmp compatible compiler"
	fi

	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	epatch "${FILESDIR}"/${P}-scons.patch
	epatch "${FILESDIR}"/${PN}-5.16.6-tests.patch
	epatch "${FILESDIR}"/${PN}-5.16.6-install.patch

	cat > custom.py <<-EOF
		platform = 'linux'
		customCPPPATH = []
		customCCFLAGS = "${CFLAGS}".split()
		customCXXFLAGS = "${CXXFLAGS}".split()
		customLIBS = []
		customLIBPATH = []
		customLINKFLAGS = "${LDFLAGS}".split()
		customSHLINKFLAGS = []
		customSWIGFLAGS = []
	EOF
}

src_compile() {
	local myconf
	[[ $(get_libdir) == "lib64" ]] && myconf+=" Lib64=1"

	escons \
		prefix=/usr \
		CC="$(tc-getCC)" \
		CXX="$(tc-getCXX)" \
		buildNewParser=1 \
		pythonVersion=$(python_get_version) \
		$(use_scons alsa useALSA) \
		$(use_scons beats buildBeats) \
		$(use_scons chua buildChuaOpcodes) \
		$(use_scons csoundac buildCsoundAC) \
		$(use_scons cxx buildInterfaces) \
		$(use_scons !debug buildRelease) \
		$(use_scons !debug noDebug) \
		$(use_scons debug NewParserDebug) \
		$(use_scons double-precision useDouble) \
		$(use_scons dssi buildDSSI) \
		$(use_scons fluidsynth buildFluidOpcodes) \
		$(use_scons fltk buildCsound5GUI) \
		$(use_scons fltk useFLTK) \
		$(use_scons image buildImageOpcodes) \
		$(use_scons jack useJack) \
		$(use_scons java buildJavaWrapper) \
		$(use_scons keyboard buildVirtual) \
		$(use_scons linear buildLinearOpcodes) \
		$(use_scons lua buildLuaOpcodes) \
		$(use_scons lua buildLuaWrapper) \
		$(use_scons luajit useLuaJIT) \
		$(use_scons nls useGettext) \
		$(use_scons osc useOSC) \
		$(use_scons openmp useOpenMP) \
		$(use_scons portaudio usePortAudio) \
		$(use_scons portmidi usePortMIDI) \
		$(use_scons pulseaudio usePulseAudio) \
		$(use_scons python buildPythonOpcodes) \
		$(use_scons python buildPythonWrapper) \
		$(use_scons !static-libs dynamicCsoundLibrary) \
		$(use_scons stk buildStkOpcodes) \
		$(use_scons tcl buildTclcsound) \
		$(use_scons !threads noFLTKThreads) \
		$(use_scons threads buildMultiCore) \
		$(use_scons utils buildUtilities) \
		$(use_scons vst buildCsoundVST) \
		${myconf}
}

src_test() {
	export LD_LIBRARY_PATH="${S}" OPCODEDIR="${S}" OPCODEDIR64="${S}"
	cd tests
	./test.py || die "tests failed"
}

src_install() {
	local myconf
	[[ $(get_libdir) == "lib64" ]] && myconf+=" --word64"

	use vim-syntax && myconf+=" --vimdir=/usr/share/vim/vimfiles"

	./install.py --instdir="${D}" --prefix=/usr ${myconf} || die "install failed"
	dodoc AUTHORS ChangeLog readme-csound5-complete.txt

	# Generate env.d file
	if use double-precision ; then
		echo OPCODEDIR64=/usr/$(get_libdir)/${PN}/plugins64 > "${T}"/62${PN}
	else
		echo OPCODEDIR=/usr/$(get_libdir)/${PN}/plugins > "${T}"/62${PN}
	fi
	echo "CSSTRNGS=/usr/share/locale" >> "${T}"/62${PN}
	use stk && echo "RAWWAVE_PATH=/usr/share/csound/rawwaves" >> "${T}"/62${PN}
	doenvd "${T}"/62${PN}

	if use nls ; then
		insinto /usr/share/locale
		for lang in ${LANGS} ; do
			use linguas_${lang} && doins -r po/${lang}
		done
	fi

	if use examples ; then
		dodoc -r examples
		docompress -x /usr/share/doc/${PF}/examples
	fi

	if use html ; then
		dohtml -r "${WORKDIR}"/html/*
	fi

	if use doc ; then
		if use linguas_fr ; then
			dodoc "${WORKDIR}"/${DOCS_P}_manual-fr.pdf
		else
			dodoc "${WORKDIR}"/${DOCS_P}_manual.pdf
		fi
	fi

	use samples && dodoc -r samples
}
