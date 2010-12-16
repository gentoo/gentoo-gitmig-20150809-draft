# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/dataplot/dataplot-20080225.ebuild,v 1.8 2010/12/16 15:26:57 jlec Exp $

EAPI="2"
inherit eutils toolchain-funcs autotools

#     DAY         MONTH    YEAR
MY_PV=${PV:4:2}_${PV:6:2}_${PV:0:4}
MY_P=dpsrc.${MY_PV}
MY_P_AUX=dplib.${MY_PV}

DESCRIPTION="A program for scientific visualization and statistical analyis"
HOMEPAGE="http://www.itl.nist.gov/div898/software/dataplot/"
SRC_URI="ftp://ftp.nist.gov/pub/dataplot/unix/dpsrc.${MY_PV}.tar.gz
	ftp://ftp.nist.gov/pub/dataplot/unix/dplib.${MY_PV}.tar.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples gd gs opengl X"

COMMON_DEPEND="opengl? ( virtual/opengl )
	gd? ( media-libs/gd[png,jpeg] )
	gs? ( app-text/ghostscript-gpl media-libs/gd[png,jpeg] )"
DEPEND="${COMMON_DEPEND}
	dev-util/pkgconfig"
RDEPEND="${COMMON_DEPEND}
	X? ( x11-misc/xdg-utils )"

S="${WORKDIR}/${MY_P}"
S_AUX="${WORKDIR}/${MY_P_AUX}"

src_unpack() {
	# unpacking and renaming because
	# upstream does not use directories
	mkdir "${S_AUX}"
	pushd "${S_AUX}"
	unpack ${MY_P_AUX}.tar.gz
	popd
	mkdir ${MY_P}
	cd "${S}"
	unpack ${MY_P}.tar.gz
}

src_prepare() {
	# autotoolization: need to fix a few files with
	# hardcoded directories (will be fixed with autoconf)
	mv DPCOPA.INC DPCOPA.INC.in
	mv dp1_linux.f dp1_linux.f.in
	mv dp1_linux_64.f dp1_linux_64.f.in
	# various fixes (mainly syntax)
	epatch "${FILESDIR}"/dpsrc-patchset-${PV}.patch
	# some fortran patches
	epatch "${FILESDIR}"/dpsrc-dp1patches-${PV}.patch
	cp "${FILESDIR}"/Makefile.am.${PV} Makefile.am
	cp "${FILESDIR}"/configure.ac.${PV} configure.ac
	eautoreconf
}

src_configure() {
	econf \
		$(use_enable gd) \
		$(use_enable gs) \
		$(use_enable opengl) \
		$(use_enable X)
}

src_install() {
	emake DESTDIR="${D}" install || die "Install failed"

	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins -r "${S_AUX}"/data/* || die "Installing examples failed"
	fi
	insinto /usr/share/dataplot
	doins "${S_AUX}"/dp{mes,sys,log}f.tex || die "Doins failed."
	doenvd "${FILESDIR}"/90${PN} || die "doenvd failed"
}

pkg_postinst() {
	elog "Before using dataplot, please run (as root):"
	elog "env-update && source /etc/profile"
}
