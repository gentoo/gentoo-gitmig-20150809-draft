# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/file/file-4.18.ebuild,v 1.3 2006/11/02 19:58:21 kanaka Exp $

inherit eutils distutils libtool toolchain-funcs

DESCRIPTION="identify a file's format by scanning binary data for patterns"
HOMEPAGE="ftp://ftp.astron.com/pub/file/"
SRC_URI="ftp://ftp.gw.com/mirrors/pub/unix/file/${P}.tar.gz
	ftp://ftp.astron.com/pub/file/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~sparc-fbsd ~x86 ~x86-fbsd"
IUSE="python"
RESTRICT="mirror" #let upstream tarballs settle first

DEPEND=""

src_unpack() {
	unpack ${P}.tar.gz
	cd "${S}"

	epatch "${FILESDIR}"/${PN}-4.15-libtool.patch #99593

	elibtoolize
	epunt_cxx

	# make sure python links against the current libmagic #54401
	sed -i "/library_dirs/s:'\.\./src':'../src/.libs':" python/setup.py

	# dont let python README kill main README #60043
	mv python/README{,.python}

	if tc-is-cross-compiler; then
		cp -rpP ${S} ${S}-native
	fi
}

src_compile() {
	local mymake=

	# To cross-compile we need to create a native build version of the 'file'
	# executable first and use it during the real build.
	if tc-is-cross-compiler; then
		cd ${S}-native
		einfo "Doing native configure"
		CC=$(tc-getBUILD_CC) econf --datadir=/usr/share/misc || die
		einfo "Doing native build of 'file'"
		CC=$(tc-getBUILD_CC) emake -C src file|| die "emake failed"
		mymake="FILE_COMPILE=${S}-native/src/file"
		export ac_cv_sizeof_uint8_t=1 ac_cv_sizeof_uint16_t=2
		export ac_cv_sizeof_uint32_t=4 ac_cv_sizeof_uint64_t=8
		cd ${S}
		einfo "Continuing with cross-compile"
	fi
	econf --datadir=/usr/share/misc || die
	emake ${mymake} || die "emake failed"

	use python && cd python && distutils_src_compile
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc ChangeLog MAINT README

	use python && cd python && distutils_src_install
}

pkg_postinst() {
	use python && distutils_pkg_postinst
}

pkg_postrm() {
	use python && distutils_pkg_postrm
}
