# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/gettext/gettext-0.12.1-r2.ebuild,v 1.12 2004/10/31 08:53:00 vapier Exp $

inherit eutils gnuconfig toolchain-funcs libtool

DESCRIPTION="GNU locale utilities"
HOMEPAGE="http://www.gnu.org/software/gettext/gettext.html"
SRC_URI="mirror://gnu/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 ppc-macos s390 sparc x86"
IUSE="bootstrap emacs nls"

DEPEND="virtual/libc"

src_unpack() {
	unpack ${A}
	cd ${S}
	use bootstrap && epatch ${FILESDIR}/${P}-bootstrap.patch
	epatch ${FILESDIR}/${P}-tempfile.patch #66355
	elibtoolize --reverse-deps
	gnuconfig_update
}

src_compile() {
	local myconf=""
	( use macos || use ppc-macos ) && myconf="--enable-nls" || myconf="`use_enable nls`"

	# Compaq Java segfaults trying to build gettext stuff, and there's
	# no good way to tell gettext to refrain from building the java
	# stuff, so... remove compaq-jdk/jre from the PATH
	if use alpha && [[ $JAVAC == *compaq* ]]; then
		PATH=$(echo ":${PATH}" | sed 's|:/opt/compaq-j[^:]*||g; s/^://')
		unset JAVA_HOME CLASSPATH JDK_HOME JAVAC
	fi

	# When updating in sparc with java the jvm segfaults
	if use sparc; then
		epatch ${FILESDIR}/${P}-without_java.patch
		myconf="--without-java"
	fi

	# Build with --without-included-gettext (will use that of glibc), as we
	# need preloadable_libintl.so for new help2man, bug #40162.
	# Also note that it only gets build with USE=nls ...
	# Lastly, we need to build without --disable-shared ...
	CXX=$(tc-getCC) \
		econf \
		--without-included-gettext \
		${myconf} || die

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
	( use macos || use ppc-macos ) && rm -f ${D}/usr/lib/charset.alias

	if [ -d ${D}/usr/doc/gettext ]
	then
		mv ${D}/usr/doc/gettext ${D}/usr/share/doc/${PF}/html
		rm -rf ${D}/usr/doc
	fi

	# Remove emacs site-lisp stuff if 'emacs' is not in USE
	if ! use emacs
	then
		rm -rf ${D}/usr/share/emacs
	fi

	dodoc AUTHORS BUGS ChangeLog DISCLAIM NEWS README* THANKS TODO
}
