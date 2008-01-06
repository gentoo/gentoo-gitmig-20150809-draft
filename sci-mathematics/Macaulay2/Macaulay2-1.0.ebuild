# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/Macaulay2/Macaulay2-1.0.ebuild,v 1.1 2008/01/06 15:51:17 markusle Exp $

inherit elisp-common eutils flag-o-matic toolchain-funcs autotools

IUSE="emacs"

DESCRIPTION="research tool for commutative algebra and algebraic geometry"
SRC_URI="mirror://gentoo/${P}-src.tar.bz2
	ftp://www.mathematik.uni-kl.de/pub/Math/Singular/Factory/factory-3-0-3.tar.gz \
	ftp://www.mathematik.uni-kl.de/pub/Math/Singular/Libfac/libfac-3-0-3.tar.gz"

HOMEPAGE="http://www.math.uiuc.edu/Macaulay2/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"

DEPEND="sys-libs/gdbm
	dev-libs/gmp
	dev-libs/ntl
	dev-libs/boehm-gc
	virtual/blas
	virtual/lapack
	dev-util/ctags
	sys-libs/ncurses
	emacs? ( virtual/emacs )"

SITEFILE=70Macaulay2-gentoo.el

pkg_setup() {

	# boehm-gc currently is broken with USE='threads'
	# (see bug #195335) causing Macaulay2 to fail
	if built_with_use =dev-libs/boehm-gc-7* threads; then
		echo
		eerror "dev-libs/boehm-gc-7* with USE=\"threads\" is"
		eerror "currently broken (see bug #195335) causing"
		eerror "Macaulay to fail building. Please re-emerge"
		eerror "dev-libs/boehm-gc-7* with USE=\"-threads\"!"
		die "boehm-gc setup error"
		echo
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-example-fix.patch

	sed -e "s:\$docdirtail/${PN}:\$docdirtail/${P}:" \
		-i configure.ac \
		|| die "Failed to fix doc install directory."
}

src_compile() {
	cd "${WORKDIR}/factory-3.0.3"
	econf --enable-NTL --prefix="${WORKDIR}" || \
		die "failed to configure factory"
	emake || die "failed to build factory"
	make install || die "failed to install factory"

	cd "${WORKDIR}/libfac"
	CPPFLAGS="-I${WORKDIR}/include" econf --with-NOSTREAMIO \
		--prefix="${WORKDIR}" || die "failed to configure libfac"
	emake || die "failed to build libfac"
	make install || die "failed to install libfac"

	cd "${S}"
	sed -e "/^docm2RelDir/s:Macaulay2:${P}:" \
		-i include/config.Makefile.in \
		|| die "failed to fix makefile"

	CXXFLAGS="${CXXFLAGS} -Wno-deprecated"
	append-ldflags "-L${WORKDIR}/$(get_libdir)"
	emake -j1 && CPPFLAGS="-I/usr/include/gc -I${WORKDIR}/include" \
		./configure --prefix="${D}/usr" --disable-encap \
		--with-lapacklibs="$(pkg-config lapack --libs)" \
		|| die "failed to configure Macaulay"

	emake -j1 || die "failed to build Macaulay"
}

# checks are currently very broken
#src_test() {
#	cd "${S}"
#	make check || die "tests failed"
#}

src_install () {
	make install || die "install failed"

	# nothing useful in here, get rid of it
	# NOTE: Macaulay installs into lib even on amd64 hence don't 
	# replace lib with $(get_libdir) below!
	rm -fr "${D}"/usr/lib \
		|| die "failed to remove empty /usr/lib"

	use emacs && elisp-site-file-install "${FILESDIR}/${SITEFILE}"
}

pkg_postinst() {
	if use emacs; then
		elisp-site-regen
		elog "If you want to set a hot key for Macaulay2 in Emacs add a line similar to"
		elog "(global-set-key [ f12 ] 'M2)"
		elog "in order to set it to F12 (or choose a different one."
	fi
}
pkg_postrm() {
	use emacs && elisp-site-regen
}
