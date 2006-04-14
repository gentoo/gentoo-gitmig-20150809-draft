# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/tetex/tetex-3.0_p1-r3.ebuild,v 1.3 2006/04/14 20:08:55 flameeyes Exp $

inherit tetex-3 flag-o-matic versionator virtualx

SMALL_PV=$(get_version_component_range 1-2 ${PV})
TETEX_TEXMF_PV=${SMALL_PV}
S=${WORKDIR}/tetex-src-${SMALL_PV}

TETEX_SRC="tetex-src-${PV}.tar.gz"
TETEX_TEXMF="tetex-texmf-${TETEX_TEXMF_PV:-${TETEX_PV}}.tar.gz"
#TETEX_TEXMF_SRC="tetex-texmfsrc-${TETEX_TEXMF_PV:-${TETEX_PV}}.tar.gz"
TETEX_TEXMF_SRC=""

DESCRIPTION="a complete TeX distribution"
HOMEPAGE="http://tug.org/teTeX/"

SRC_PATH_TETEX=ftp://cam.ctan.org/tex-archive/systems/unix/teTeX/current/distrib
SRC_URI="http://dev.gentoo.org/~nattfodd/tetex/${TETEX_SRC}
	${SRC_PATH_TETEX}/${TETEX_TEXMF}
	http://dev.gentoo.org/~nattfodd/tetex/${P}-gentoo.tar.gz"

KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~ppc ~ppc-macos ~ppc64 ~s390 ~sparc ~x86 ~x86-fbsd"

# these are defined in tetex.eclass and tetex-3.eclass
IUSE=""
DEPEND=""

src_unpack() {
	tetex-3_src_unpack
	cd ${S}
	epatch ${FILESDIR}/${PN}-${SMALL_PV}-kpathsea-pic.patch

	# bug 85404
	epatch ${FILESDIR}/${PN}-${SMALL_PV}-epstopdf-wrong-rotation.patch

	epatch ${FILESDIR}/${P}-amd64-xdvik-wp.patch
	epatch ${FILESDIR}/${P}-mptest.patch

	#bug 98029
	epatch ${FILESDIR}/${P}-fmtutil-etex.patch

	#bug 115775
	epatch ${FILESDIR}/${P}-xpdf-vulnerabilities.patch

	# bug 94860
	epatch ${FILESDIR}/${P}-pdftosrc-install.patch

	# bug 126918
	epatch ${FILESDIR}/${P}-create-empty-files.patch

	# Construct a Gentoo site texmf directory
	# that overlays the upstream supplied
	epatch ${FILESDIR}/${P}-texmf-site.patch
}

src_compile() {
	#bug 119856
	export LC_ALL=C

	# dvipng has its own ebuild (fix for bug #129044).
	TETEX_ECONF="${TETEX_ECONF} --without-dvipng"

	tetex-3_src_compile
}

src_test() {
	fmtutil --fmtdir "${S}/texk/web2c" --all
	# The check target tries to access X display, bug #69439.
	Xmake check || die "Xmake check failed."
}

src_install() {
	insinto /usr/share/texmf/dvips/pstricks
	doins ${FILESDIR}/pst-circ.pro

	# install pdftosrc man page, bug 94860
	doman ${S}/texk/web2c/pdftexdir/pdftosrc.1

	tetex-3_src_install

	# Create Gentoo site texmf directory
	keepdir /usr/share/texmf-site

	# virtex was removed from tetex-3
	# The links has to be relative, since the targets
	# is not present at this stage and MacOS doesn't
	# like non-existing targets, bug #106886.
	cd ${D}/usr/bin/
	ln -snf tex virtex
	ln -snf pdftex pdfvirtex
}

pkg_postinst() {
	tetex-3_pkg_postinst

	einfo
	einfo "This release removes dvipng since it is provided in app-text/dvipng"
	einfo
}
