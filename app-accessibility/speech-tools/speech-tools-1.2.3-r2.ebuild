# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/speech-tools/speech-tools-1.2.3-r2.ebuild,v 1.3 2005/04/06 20:53:31 hansmi Exp $

IUSE="doc"

inherit eutils fixheadtails toolchain-funcs

MY_P=${P/-/_}

DESCRIPTION="Speech tools for Festival Text to Speech engine"
HOMEPAGE="http://www.cstr.ed.ac.uk/"
SRC_URI="http://www.cstr.ed.ac.uk/download/festival/1.4.3/${MY_P}-release.tar.gz
	 doc? ( http://www.cstr.ed.ac.uk/download/festival/1.4.3/festdoc-1.4.2.tar.gz )
	 mirror://gentoo/speech-tools-1.2.3-gcc3.4.patch.bz2"

LICENSE="FESTIVAL BSD as-is"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"

RDEPEND="sys-libs/ncurses"
DEPEND="${RDEPEND}
	app-arch/cpio
	sys-apps/findutils
	>=sys-apps/sed-4"

S="${WORKDIR}/speech_tools"

src_unpack() {
	unpack ${MY_P}-release.tar.gz
	unpack speech-tools-1.2.3-gcc3.4.patch.bz2

	cd ${S}
	use doc && unpack festdoc-1.4.2.tar.gz && mv festdoc-1.4.2 festdoc

	if [ "$(gcc-version)" == "3.3" ]; then
		epatch ${FILESDIR}/${PN}-gcc3.3.diff
	fi
	if [ "$(gcc-version)" == "3.4" ]; then
		epatch ${WORKDIR}/${P}-gcc3.4.patch
	fi
	ht_fix_file config.guess
	sed -i 's:-O3:$(OPTIMISE_CXXFLAGS):' base_class/Makefile

	# Compile fix for #41329.
	sed -i 's/-fpic/-fPIC/' config/compilers/gcc_defaults.mak
}

src_compile() {
	econf || die
	emake -j1 \
		OPTIMISE_CXXFLAGS="${CXXFLAGS}" \
		OPTIMISE_CCFLAGS="${CFLAGS}" \
		|| die
}

src_install() {
	cd ${S}/lib
	dolib.so libestbase.so.1.2.3.1
	dosym /usr/$(get_libdir)/libestbase.so.1.2.3.1 /usr/$(get_libdir)/libestbase.so
	dolib.so libeststring.so.1.2
	dosym /usr/$(get_libdir)/libeststring.so.1.2 /usr/$(get_libdir)/libeststring.so
	dolib.a libestbase.a
	dolib.a libestools.a
	dolib.a libeststring.a

	exeinto /usr/libexec/speech-tools
	cd ${S}/bin

	dodir /usr/lib/speech-tools/share/testsuite
	for file in * ; do
		[ "${file}" = "Makefile" ] && continue
		doexe ${file}
		dstfile="/usr/libexec/speech-tools/${file}"
		dosed "s:${S}/testsuite/data:/usr/share/speech-tools/testsuite:g" ${dstfile}
		dosed "s:${S}/bin:/usr/libexec/speech-tools:g" ${dstfile}
		dosed "s:${S}/main:/usr/libexec/speech-tools:g" ${dstfile}

		# This just changes LD_LIBRARY_PATH
		dosed "s:${S}/lib:/usr/$(get_libdir):g" ${dstfile}
	done

	insinto /usr/share/speech-tools/lib/siod
	cd ${S}/lib/siod
	doins *

	insinto /usr/share/doc/${PF}/example_data
	cd ${S}/lib/example_data
	doins *

	cd ${S}
	find config -print | cpio -pmd ${D}/usr/share/speech-tools || die "Unable to install config files"

	cd ${S}/include
	dodir /usr/include/speech-tools
	find . -print | cpio -pmd ${D}/usr/include/speech-tools || die "Unable to install include files"

	dosym /usr/include/speech-tools /usr/share/speech-tools/include

	chown -R root:root ${D}

	find ${D}/usr/share/speech-tools/config -type f | xargs sed -i 's/-ltermcap/-lncurses/g'

	insinto /etc/env.d
	doins ${FILESDIR}/58speech-tools

	cd ${S}
	dodoc README INSTALL
	cd ${S}/lib
	dodoc cstrutt.dtd

	if use doc ; then
		cd ${S}/festdoc/speech_tools/doc
		dohtml -r *
	fi
}
