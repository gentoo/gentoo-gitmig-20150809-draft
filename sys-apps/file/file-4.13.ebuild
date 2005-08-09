# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/file/file-4.13.ebuild,v 1.10 2005/08/09 16:00:42 ka0ttic Exp $

inherit flag-o-matic eutils distutils libtool toolchain-funcs

DESCRIPTION="Program to identify a file's format by scanning binary data for patterns"
HOMEPAGE="ftp://ftp.astron.com/pub/file/"
SRC_URI="ftp://ftp.gw.com/mirrors/pub/unix/file/${P}.tar.gz
	ftp://ftp.astron.com/pub/file/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k mips ppc ppc64 s390 sh sparc x86"
IUSE="python build"

DEPEND="!build? ( python? ( virtual/python ) )"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# the magic and src subdir sometimes don't get along #81974
	sed -i -e '/^SUBDIRS/s:magic::' Makefile.in

	# Rename ia64 labels (from Fedora)
	epatch "${FILESDIR}"/${P}-ia64.patch

	# This tweaks the output format for mips binaries so things like 
	# libtool don't barf all over the place when trying to parse it.
	epatch "${FILESDIR}"/${PN}-4.xx-mips-gentoo.patch

	# The build process tries to run the compiled file ... not a good
	# thing if file was cross compiled ;)
	tc-is-cross-compiler && epatch "${FILESDIR}"/${P}-cross-compile.patch

	# misc updates
	cat "${FILESDIR}"/*.magic >> magic/magic.mime
	uclibctoolize

	# make sure python links against the current libmagic #54401
	sed -i "/library_dirs/s:'\.\./src':'../src/.libs':" python/setup.py

	# dont let python README kill main README #60043
	mv python/README{,.python}
}

src_compile() {
	# file command segfaults on hppa -  reported by gustavo@zacarias.com.ar
	[[ ${ARCH} == hppa ]] && filter-flags -mschedule=8000

	econf --datadir=/usr/share/misc || die
	emake || die "emake failed"
	emake -C magic || die "emake magic failed"

	use python && cd python && distutils_src_compile
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	make DESTDIR="${D}" install -C magic || die "make magic install failed"

	if ! use build ; then
		dodoc ChangeLog MAINT README
		use python && cd python && distutils_src_install
	else
		rm -r "${D}"/usr/share/man "${D}"/usr/lib/*.a
	fi
}

pkg_postinst() {
	use python && distutils_pkg_postinst
}

pkg_postrm() {
	use python && distutils_pkg_postrm
}
