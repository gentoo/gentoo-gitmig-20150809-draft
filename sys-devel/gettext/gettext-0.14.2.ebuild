# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/gettext/gettext-0.14.2.ebuild,v 1.7 2005/08/24 00:35:05 vapier Exp $

inherit flag-o-matic eutils toolchain-funcs mono libtool elisp-common

DESCRIPTION="GNU locale utilities"
HOMEPAGE="http://www.gnu.org/software/gettext/gettext.html"
SRC_URI="mirror://gnu/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc-macos ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE="emacs nls"

DEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"

	epunt_cxx

	epatch "${FILESDIR}"/${PN}-0.14.1-lib-path-tests.patch #81628
	# java sucks
	epatch "${FILESDIR}"/${PN}-0.14.1-without_java.patch
	epatch "${FILESDIR}"/${PN}-0.14.2-no-java-tests.patch
	# Fix race, bug #85054
	epatch "${FILESDIR}"/${PN}-0.14.2-fix-race.patch

	# bundled libtool seems to be broken so skip certain rpath tests
	# http://lists.gnu.org/archive/html/bug-libtool/2005-03/msg00070.html
	sed -i \
		-e '2iexit 77' \
		autoconf-lib-link/tests/rpath-3*[ef] || die "sed tests"

	# use Gentoo std docdir
	sed -i \
		-e "/^docdir=/s:=.*:=/usr/share/doc/${PF}:" \
		gettext-runtime/configure \
		gettext-tools/configure \
		gettext-tools/examples/installpaths.in \
		|| die "sed docdir"

	if use ppc-macos ; then
		glibtoolize
		append-flags -bind_at_load
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
	make install DESTDIR="${D}" || die "install failed"
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
	if use emacs ; then
		elisp-site-file-install ${FILESDIR}/50po-mode-gentoo.el
	else
		rm -rf ${D}/usr/share/emacs
	fi

	dodoc AUTHORS BUGS ChangeLog DISCLAIM NEWS README* THANKS TODO
}

pkg_postinst() {
	use emacs && elisp-site-regen
	ewarn "Any package that linked against the previous version"
	ewarn "of gettext will have to be rebuilt."
	ewarn "Please 'emerge gentoolkit' and run:"
	ewarn "revdep-rebuild --soname libintl.so.2"
}

pkg_postrm() {
	use emacs && elisp-site-regen
}
