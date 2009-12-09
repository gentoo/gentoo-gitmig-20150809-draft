# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/ptex/ptex-3.1.10_p20090610.ebuild,v 1.7 2009/12/09 19:37:26 nixnut Exp $

# jmbreuer FOR DEV ONLY
RESTRICT="mirror test"

TETEX_PV=3.0_p1

inherit eutils tetex-3 flag-o-matic autotools multilib

SMALL_PV="${TETEX_PV/_p*}"
TETEX_TEXMF_PV="${SMALL_PV}"
TETEX_S="${WORKDIR}/tetex-src-${SMALL_PV}"

DESCRIPTION="TeX distribution teTeX with Japanese patch collection 'ptetex3'"
HOMEPAGE="http://www.nn.iij4u.or.jp/~tutimura/tex/ptetex.html"

TETEX_SRC="tetex-src-${SMALL_PV}.tar.gz"
TETEX_TEXMF="tetex-texmf-${TETEX_TEXMF_PV:-${TETEX_PV}}"
TETEX_TEXMF_SRC="tetex-texmf-${TETEX_TEXMF_PV:-${TETEX_PV}}po.tar.gz"
PTETEX="ptetex3-${PV/*_p}"
PTETEX_CMAP="ptetex-cmap-20090506"

SRC_PATH_TETEX="http://www.ctan.org/tex-archive/obsolete/systems/unix/teTeX/3.0/distrib"
SRC_URI="${SRC_PATH_TETEX}/${TETEX_SRC}
	${SRC_PATH_TETEX}/${TETEX_TEXMF_SRC}
	http://tutimura.ath.cx/~nob/tex/ptetex/ptetex3/${PTETEX}.tar.gz
	http://tutimura.ath.cx/~nob/tex/ptetex/ptetex-cmap/${PTETEX_CMAP}.tar.gz
	mirror://gentoo/${PN}-3.1.10_p20071122-dviljk-security-fixes.patch.bz2"

KEYWORDS="alpha amd64 arm hppa ia64 ppc ~ppc64 sh sparc x86"

BUILD_DIR="${WORKDIR}/build/usr"

LICENSE="GPL-2 BSD"
IUSE="X motif Xaw3d neXt iconv unicode"

RDEPEND="!app-text/tetex
	!<app-text/ptetex-3.1.9
	!app-text/dvipdfmx
	!app-text/xdvik
	!dev-texlive/texlive-basic
	!dev-texlive/texlive-latex
	!dev-texlive/texlive-latexrecommended
	media-libs/t1lib
	media-libs/gd
	X? (
		>=media-libs/freetype-2.3.4
		|| (
			media-fonts/ja-ipafonts
			media-fonts/ipamonafont
			media-fonts/vlgothic
			media-fonts/sazanami
			media-fonts/kochi-substitute
		)
	)"
DEPEND="${RDEPEND}
	app-arch/unzip"

S="${WORKDIR}/${PTETEX}"

src_unpack() {
	mkdir -p "${WORKDIR}/${TETEX_TEXMF}"
	cd "${WORKDIR}/${TETEX_TEXMF}"
	unpack ${TETEX_TEXMF_SRC}
	cd "${WORKDIR}"
	unpack ${TETEX_SRC}
	cd "${WORKDIR}"
	unpack ${PN}-3.1.10_p20071122-dviljk-security-fixes.patch.bz2
	unpack ${PTETEX}.tar.gz
	unpack ${PTETEX_CMAP}.tar.gz
	echo ">>> Unpacking jis and morisawa fonts ..."
	tar xzf "${WORKDIR}"/${PTETEX}/archive/jis.tar.gz -C "${WORKDIR}" || die
	tar xzf "${WORKDIR}"/${PTETEX}/archive/morisawa.tar.gz -C "${WORKDIR}" || die

	# Gentoo box reserves variable ${P}!!
	cd "${S}"
	epatch "${FILESDIR}"/${P}-gentoo.patch

	cat <<EOF > "${S}"/my_option
SRC_DIR="${WORKDIR}"
TMP_PREFIX="${BUILD_DIR}"
PREFIX=/usr
DATADIR=/usr/share
TEXMFDIST="${WORKDIR}/${TETEX_TEXMF}"
TEXSRC_EXTRACTED="${WORKDIR}"
#make_option vartexfonts=/var/lib/texmf
make_option vartexfonts="${T}/texfonts"
make_option CC="$(tc-getCC)"
make_option CXX="$(tc-getCXX)"
JAPANESE=international
XDVI=echo
PXDVI=echo
PLATEX209=no
STRIP=no
conf_option --without-dviljk
conf_option --without-dvipng
conf_option --without-info
conf_option --without-texi2html
conf_option --without-texinfo

conf_option --with-system-zlib
conf_option --with-system-pnglib
conf_option --with-system-gd
conf_option --with-system-ncurses
conf_option --with-system-t1lib
conf_option --enable-shared
EOF

	if use iconv ; then
		echo "conf_option --enable-kanji-iconv" >> "${S}"/my_option
	fi

	if use unicode ; then
		echo "KANJI_CODE=UTF8" >> "${S}"/my_option
	else
		echo "KANJI_CODE=EUC" >> "${S}"/my_option
	fi

	# copied from tetex-3.eclass and modified
	if use X ; then
		if use motif ; then
			toolkit="motif"
		elif use neXt ; then
			toolkit="neXtaw"
		elif use Xaw3d ; then
			toolkit="xaw3d"
		else
			toolkit="xaw"
		fi
		echo "export CPPFLAGS=\"${CPPFLAGS} $(freetype-config --cflags)\"" >> "${S}"/my_option
		echo "export LDFLAGS=\"${LDFLAGS} $(freetype-config --libs)\"" >> "${S}"/my_option
		echo "conf_option --with-xdvi-x-toolkit=${toolkit}" >> "${S}"/my_option
	else
		echo "conf_option --without-x" >> "${S}"/my_option
		echo "conf_option --without-xdvik" >> "${S}"/my_option
		echo "conf_option --without-pxdvik" >> "${S}"/my_option
	fi

	cd "${S}"
	unset TEXMFMAIN TEXMF HOME
	emake -j1 x || die "emake x failed"

	cd "${TETEX_S}"

	epatch "${FILESDIR}/tetex-${SMALL_PV}-kpathsea-pic.patch"

	# bug 85404
	epatch "${FILESDIR}/${PN}-3.1.10_p20071122-epstopdf-wrong-rotation.patch"

	# ptetex included
	#epatch "${FILESDIR}/tetex-${TETEX_PV}-amd64-xdvik-wp.patch"
	epatch "${FILESDIR}/tetex-${TETEX_PV}-mptest.patch"

	#bug 98029
	# no need
	#epatch "${FILESDIR}/${PN}-3.1.10_p20071122-fmtutil-etex.patch"

	#bug 115775
	# ptex included
	#epatch "${FILESDIR}/tetex-${TETEX_PV}-xpdf-vulnerabilities.patch"

	# bug 94860
	epatch "${FILESDIR}/${PN}-3.1.10_p20071122-pdftosrc-install.patch"

	# bug 126918
	epatch "${FILESDIR}/tetex-${TETEX_PV}-create-empty-files.patch"

	# bug 94901
	epatch "${FILESDIR}/tetex-${TETEX_PV}-dvipdfm-timezone.patch"

	# security bug #170861
	# ptetex included
	# epatch "${FILESDIR}/tetex-${TETEX_PV}-CVE-2007-0650.patch"

	# security bug #188172
	# ptetex included
	#epatch "${FILESDIR}/tetex-${TETEX_PV}-xpdf-CVE-2007-3387.patch"

	# security bug #198238
	epatch "${FILESDIR}/tetex-${TETEX_PV}-dvips_bufferoverflow.patch"

	# securty bug #196735
	epatch "${FILESDIR}/xpdf-3.02pl2.patch"

	# Construct a Gentoo site texmf directory
	# that overlays the upstream supplied
	# target not found
	#epatch "${FILESDIR}/tetex-${TETEX_PV}-texmf-site.patch"

	# security bug #198238
	epatch "${WORKDIR}/${PN}-3.1.10_p20071122-dviljk-security-fixes.patch"

	# security bug #198238 and bug #193437
	epatch "${FILESDIR}/tetex-${TETEX_PV}-t1lib-SA26241_buffer_overflow.patch"

	# security bug #282874
	epatch "${FILESDIR}/CVE-2009-1284.patch"

	epatch "${FILESDIR}/${P}-getline.patch"

	cd "${TETEX_S}/texk/dviljk"
	eautoreconf
}

src_compile() {
	unset TEXMFMAIN TEXMF HOME

	emake -j1 c || die "emake c failed"
	emake -j1 macro || die "emake macro failed"
	emake -j1 otf || die "emake otf failed"
	emake -j1 fonty || die "emake fonty failed"
	emake -j1 babel || die "emake babel failed"

	einfo "Setting ptetex-cmap ..."
	cd "${WORKDIR}/${PTETEX_CMAP}"
	PATH="${BUILD_DIR}/bin:${PATH}" \
	LD_LIBRARY_PATH="${BUILD_DIR}/lib:${LD_LIBRARY_PATH}" \
	TEXMFMAIN="${BUILD_DIR}/share/texmf" \
		./setup.sh "${BUILD_DIR}"/share/texmf/fonts/cmap
}

src_test() {
	PATH="${BUILD_DIR}/bin:${PATH}" \
	LD_LIBRARY_PATH="${BUILD_DIR}/lib:${LD_LIBRARY_PATH}" \
	TEXMFMAIN="${BUILD_DIR}/share/texmf" \
		emake -j1 test || die "emake test failed"
}

src_install() {
	einfo "Installing ptetex3 binaries ..."
	dobin "${BUILD_DIR}"/bin/*
	dolib "${BUILD_DIR}"/lib/*

	einfo "Installing /usr/include/* files ..."
	insinto /usr/include
	doins -r "${BUILD_DIR}"/include/*

	einfo "Installing /usr/share/* files ..."
	insinto /usr/share
	cp -dr "${BUILD_DIR}"/share/* "${D}"/usr/share

	einfo "Installing document files ..."
	doman "${BUILD_DIR}"/man/*/*
	doinfo "${BUILD_DIR}"/info/*

	einfo "Installing jis and morisawa fonts ..."
	insinto /usr/share/texmf/fonts/tfm
	doins -r "${WORKDIR}"/jis/tfm/*        || die "installing jis/tfm failed"
	doins -r "${WORKDIR}"/morisawa/tfm/*   || die "installing morisawa/tfm failed"

	einfo "Installing texmf files ..."
	find "${WORKDIR}"/${TETEX_TEXMF} -maxdepth 1 -mindepth 1 -type f | xargs rm -f
	insinto /usr/share/texmf
	doins -r "${WORKDIR}"/${TETEX_TEXMF}/*

	einfo "Installing other files ..."
	insinto /usr/share/texmf/fonts/map/dvips/tetex
	insinto /usr/share/texmf/web2c
	doins -r "${BUILD_DIR}"/share/texmf-var/web2c/*.fmt

	einfo "Removing unnecessary files ..."
	rm -r "${D}"/usr/share/texmf/doc
	rm -r "${D}"/usr/share/texmf/web2c/texmf.cnf.*
	rm -r "${D}"/usr/share/texmf/web2c/fmtutil.cnf.*
	find "${D}"/usr/share/texmf | grep "ls-R" | xargs rm -f

	einfo "Installing texmf-update scripte ..."
	dosbin "${FILESDIR}"/texmf-update

	dodoc ChangeLog* README*
}

pkg_postinst() {
	tetex-3_pkg_postinst

	elog
	elog "Japanese dvips and xdvi have been renamed to pdvipsk and pxdvik."
	elog
	elog "To use proper Japanese font in dvips/dvipdfmx/xdvi/pdftex, you"
	elog "needs to run updmap or updmap-sys w/ map. More deteil info about"
	elog "this fonts central configuration can be available at following"
	elog "ptetex Wiki:"
	elog " http://tutimura.ath.cx/ptetex/?%A5%D5%A5%A9%A5%F3%A5%C8%A4%CE%BD%B8%C3%E6%B4%C9%CD%FD"
	elog
}
