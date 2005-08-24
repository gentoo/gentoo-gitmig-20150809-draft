# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/speech-tools/speech-tools-1.2.3-r3.ebuild,v 1.5 2005/08/24 07:41:21 flameeyes Exp $

IUSE="doc esd X"

inherit eutils fixheadtails toolchain-funcs

MY_P=${P/-/_}

DESCRIPTION="Speech tools for Festival Text to Speech engine"
HOMEPAGE="http://www.cstr.ed.ac.uk/"
CSTR="http://www.cstr.ed.ac.uk/download/festival/1.4.3"
SRC_URI="${CSTR}/${MY_P}-release.tar.gz
	 doc? ( ${CSTR}/festdoc-1.4.2.tar.gz )
	 mirror://gentoo/speech-tools-${PV}-gcc3.4.patch.bz2"

LICENSE="FESTIVAL BSD as-is"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"

RDEPEND="sys-libs/ncurses"
DEPEND="${RDEPEND}
	app-arch/cpio
	sys-apps/findutils
	>=sys-apps/sed-4"

S="${WORKDIR}/speech_tools"

src_unpack() {
	unpack ${A}

	use doc && mv festdoc-1.4.2 festdoc

	cd ${S}
	[[ "$(gcc-version)" == "3.3" ]] && epatch ${FILESDIR}/${PN}-gcc3.3.diff
	[[ "$(gcc-version)" == "3.4" ]] && epatch ${WORKDIR}/${P}-gcc3.4.patch

	ht_fix_file ${S}/config.guess
	sed -i -e 's:-O3:$(OPTIMISE_CXXFLAGS):' ${S}/base_class/Makefile

	# Compile fix for #41329.
	sed -i -e 's/-fpic/-fPIC/' ${S}/config/compilers/gcc_defaults.mak

	use esd && sed -i -e 's/# \(INCLUDE_MODULES += ESD_AUDIO\)/\1/' ${S}/config/config.in
	use X || sed -i -e 's/-lX11 -lXt//' ${S}/config/modules/esd_audio.mak
}

src_compile() {
	econf || die
	emake -j1 OPTIMISE_CXXFLAGS="${CXXFLAGS}" OPTIMISE_CCFLAGS="${CFLAGS}" CC="$(tc-getCC)" CXX="$(tc-getCXX)" || die
}

src_install() {
	dolib.so ${S}/lib/{libestbase.so.1.2.3.1,libeststring.so.1.2}
	dosym /usr/$(get_libdir)/libestbase.so.1.2.3.1 /usr/$(get_libdir)/libestbase.so
	dosym /usr/$(get_libdir)/libeststring.so.1.2 /usr/$(get_libdir)/libeststring.so
	dolib.a ${S}/lib/{libestbase.a,libestools.a,libeststring.a}

	cd ${S}/bin
	for file in *; do
		[ "${file}" = "Makefile" ] && continue
		dobin ${file}
		dstfile="/usr/bin/${file}"
		dosed "s:${S}/testsuite/data:/usr/share/speech-tools/testsuite:g" ${dstfile}
		dosed "s:${S}/bin:/usr/libexec/speech-tools:g" ${dstfile}
		dosed "s:${S}/main:/usr/libexec/speech-tools:g" ${dstfile}

		# This just changes LD_LIBRARY_PATH
		dosed "s:${S}/lib:/usr/$(get_libdir):g" ${dstfile}
	done

	exeinto /usr/libexec/speech-tools
	for file in `find ${S}/main -perm +100 -type f`; do
		doexe ${file}
	done

	insinto /usr/share/speech-tools/lib/siod
	doins ${S}/lib/siod/*

	insinto /usr/share/doc/${PF}/example_data
	doins ${S}/lib/example_data/*

	cd ${S}
	find config -print | cpio -pmd ${D}/usr/share/speech-tools || die "Unable to install config files"

	dodir /usr/include/speech-tools
	cd ${S}/include
	find . -print | cpio -pmd ${D}/usr/include/speech-tools || die "Unable to install include files"
	dosym /usr/include/speech-tools /usr/share/speech-tools/include

	chown -R root:0 ${D}

	find ${D}/usr/share/speech-tools/config -type f | xargs sed -i -e 's/-ltermcap/-lncurses/g'

	doenvd ${FILESDIR}/58speech-tools

	dodoc ${S}/{README,INSTALL}
	dodoc ${S}/lib/cstrutt.dtd

	use doc && dohtml -r ${WORKDIR}/festdoc/speech_tools/doc/*
}
