# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/gettext/gettext-0.14.1.ebuild,v 1.11 2004/10/28 15:57:16 vapier Exp $

inherit eutils gnuconfig toolchain-funcs mono

DESCRIPTION="GNU locale utilities"
HOMEPAGE="http://www.gnu.org/software/gettext/gettext.html"
SRC_URI="mirror://gnu/${PN}/${P}.tar.gz
	mirror://gentoo/${P}-bootstrap.patch.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-*"
IUSE="bootstrap emacs nls"

DEPEND="virtual/libc"

src_unpack() {
	unpack ${A}
	cd ${S}
	use bootstrap && epatch ${WORKDIR}/${P}-bootstrap.patch
	if use sparc; then
		epatch ${FILESDIR}/${P}-without_java.patch
		epatch ${FILESDIR}/${P}-no-java-tests.patch
	fi
	gnuconfig_update
}

src_compile() {
	# Compaq Java segfaults trying to build gettext stuff, and there's
	# no good way to tell gettext to refrain from building the java
	# stuff, so... remove compaq-jdk/jre from the PATH
	if use alpha && [[ $JAVAC == *compaq* ]]; then
		PATH=$(echo ":${PATH}" | sed 's|:/opt/compaq-j[^:]*||g; s/^://')
		unset JAVA_HOME CLASSPATH JDK_HOME JAVAC
	fi

	# When updating in sparc with java the jvm segfaults
	use sparc && myconf="${myconf} --without-java"
	use ppc-macos && myconf="${myconf} --enable-nls"

	# Build with --without-included-gettext (will use that of glibc), as we
	# need preloadable_libintl.so for new help2man, bug #40162.
	# Also note that it only gets build with USE=nls ...
	# Lastly, we need to build without --disable-shared ...
	CXX=$(tc-getCC) \
		econf \
		--without-included-gettext \
		$(use_enable nls) \
		${myconf} \
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

	# Glibc includes gettext; this isn't needed anymore
#	rm -rf ${D}/usr/include
#	rm -rf ${D}/usr/lib/lib*.{a,so}

	# Again, installed by glibc
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

pkg_postinst() {
	ewarn "Any package that linked against the previous version"
	ewarn "of gettext will have to be rebuilt."
	ewarn "Please 'emerge gentoolkit' and run 'revdep-rebuild'"
}
