# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/gettext/gettext-0.14.1.ebuild,v 1.14 2004/11/05 03:11:22 vapier Exp $

inherit eutils gnuconfig toolchain-funcs mono libtool

DESCRIPTION="GNU locale utilities"
HOMEPAGE="http://www.gnu.org/software/gettext/gettext.html"
SRC_URI="mirror://gnu/${PN}/${P}.tar.gz
	mirror://gentoo/${P}-bootstrap.patch.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~ppc-macos ~s390 ~sparc ~x86"
IUSE="bootstrap emacs nls"

DEPEND="virtual/libc"

src_unpack() {
	unpack ${A}
	cd ${S}

	# remove C++ requirements while bootstrapping
	use bootstrap && epatch ${WORKDIR}/${P}-bootstrap.patch

	# java sucks
	epatch ${FILESDIR}/${P}-without_java.patch
	epatch ${FILESDIR}/${P}-no-java-tests.patch

	elibtoolize --reverse-deps
	gnuconfig_update
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
	rm -f ${D}/usr/include/libintl.h
	rm -f ${D}/usr/$(get_libdir)/libintl.*
	rm -rf ${D}/usr/share/locale/locale.alias
	# /usr/lib/charset.alias is provided by Mac OS X
	use ppc-macos && rm -f ${D}/usr/lib/charset.alias

	# older gettext's sometimes installed libintl ...
	# need to keep the linked version or the system
	# could die (things like sed link against it :/)
	if [ -e "${ROOT}"/usr/$(get_libdir)/libintl.so.2 ] ; then
		cp -a ${ROOT}/usr/$(get_libdir)/libintl.so.2* ${D}/usr/$(get_libdir)/
		touch ${D}/usr/$(get_libdir)/libintl.so.2*
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
	ewarn "revdep-rebuild --soname libintl.so.2"
}
