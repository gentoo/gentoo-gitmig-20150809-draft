# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/gettext/gettext-0.12.1-r1.ebuild,v 1.4 2004/02/09 04:34:46 vapier Exp $

inherit eutils

DESCRIPTION="GNU locale utilities"
HOMEPAGE="http://www.gnu.org/software/gettext/gettext.html"
SRC_URI="mirror://gnu/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha hppa ~mips ~arm -amd64 ~ia64"
IUSE="nls"

DEPEND="virtual/glibc"

src_unpack() {
	unpack ${A}
	cd ${S}
	use bootstrap && epatch ${FILESDIR}/${P}-bootstrap.patch
}

src_compile() {
	local myconf=
	use nls || myconf="--disable-nls"

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
	CXX=${CC} econf \
		--without-included-gettext \
		${myconf} || die

	emake || die
}

src_install() {
	einstall \
		lispdir=${D}/usr/share/emacs/site-lisp \
		docdir=${D}/usr/share/doc/${PF}/html \
		|| die

	exeopts -m0755
	exeinto /usr/bin
	doexe misc/gettextize

	# Glibc includes gettext; this isn't needed anymore
#	rm -rf ${D}/usr/include
#	rm -rf ${D}/usr/lib/lib*.{a,so}

	# Again, installed by glibc
	rm -rf ${D}/usr/share/locale/locale.alias

	if [ -d ${D}/usr/doc/gettext ]
	then
		mv ${D}/usr/doc/gettext ${D}/usr/share/doc/${PF}/html
		rm -rf ${D}/usr/doc
	fi

	dodoc AUTHORS BUGS COPYING ChangeLog DISCLAIM NEWS README* THANKS TODO
}
