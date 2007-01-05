# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/gettext/gettext-0.14.1-r1.ebuild,v 1.5 2007/01/05 09:15:35 flameeyes Exp $

inherit eutils toolchain-funcs mono libtool

DESCRIPTION="GNU locale utilities"
HOMEPAGE="http://www.gnu.org/software/gettext/gettext.html"
SRC_URI="mirror://gnu/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc-macos ppc64 s390 sh sparc x86"
IUSE="emacs nls"

DEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"

	epunt_cxx

	epatch "${FILESDIR}"/${P}-lib-path-tests.patch #81628
	epatch "${FILESDIR}"/${P}-tempfile.patch #66355
	# java sucks
	epatch "${FILESDIR}"/${P}-without_java.patch
	epatch "${FILESDIR}"/${P}-no-java-tests.patch

	if use ppc-macos ; then
		elibtoolize
	else
		elibtoolize --reverse-deps
	fi
}

src_compile() {
	# Build with --without-included-gettext (will use that of glibc), as we
	# need preloadable_libintl.so for new help2man, bug #40162.
	# Also note that it only gets build with USE=nls ...
	# Lastly, we need to build without --disable-shared ...
	CXX=$(tc-getCC) \
	econf \
		--without-java \
		--without-included-gettext \
		$(use_enable nls) \
		|| die
	emake || die
}

src_install() {
	einstall \
		lispdir=${D}/usr/share/emacs/site-lisp \
		docdir=${D}/usr/share/doc/${PF}/html \
		|| die
	dosym msgfmt /usr/bin/gmsgfmt #43435

	exeopts -m0755
	exeinto /usr/bin
	doexe gettext-tools/misc/gettextize || die "doexe"

	# remove stuff that glibc handles
	if ! use ppc-macos; then
		# Mac OS X does not provide these files.
		rm -f ${D}/usr/include/libintl.h
		rm -f ${D}/usr/$(get_libdir)/libintl.*
	fi
	rm -rf ${D}/usr/share/locale/locale.alias

	# older gettext's sometimes installed libintl ...
	# need to keep the linked version or the system
	# could die (things like sed link against it :/)
	if use ppc-macos; then
		rm -f ${D}/usr/lib/charset.alias
		if [ -e "${ROOT}"/usr/$(get_libdir)/libintl.2.dylib ] ; then
			cp -pPR ${ROOT}/usr/$(get_libdir)/libintl.2.dylib ${D}/usr/$(get_libdir)/
			touch ${D}/usr/$(get_libdir)/libintl.2.dylib
		fi
	else
		if [ -e "${ROOT}"/usr/$(get_libdir)/libintl.so.2 ] ; then
			cp -pPR ${ROOT}/usr/$(get_libdir)/libintl.so.2* ${D}/usr/$(get_libdir)/
			touch ${D}/usr/$(get_libdir)/libintl.so.2*
		fi
	fi

	if [ -d ${D}/usr/doc/gettext ]
	then
		mv ${D}/usr/doc/gettext ${D}/usr/share/doc/${PF}/html
		rm -rf ${D}/usr/doc
	fi

	# Remove emacs site-lisp stuff if 'emacs' is not in USE
	use emacs || rm -rf ${D}/usr/share/emacs

	dodoc AUTHORS BUGS ChangeLog DISCLAIM NEWS README* THANKS TODO
}

pkg_postinst() {
	ewarn "Any package that linked against the previous version"
	ewarn "of gettext will have to be rebuilt."
	ewarn "Please 'emerge gentoolkit' and run:"
	ewarn "revdep-rebuild --library libintl.so.2"
}
