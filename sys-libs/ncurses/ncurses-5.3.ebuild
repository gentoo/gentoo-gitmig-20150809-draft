# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/ncurses/ncurses-5.3.ebuild,v 1.2 2002/10/20 06:06:47 azarah Exp $

IUSE=""

inherit flag-o-matic
filter-flags "-fno-exceptions"

S="${WORKDIR}/${P}"
DESCRIPTION="Linux console display library"
HOMEPAGE="http://www.gnu.org/software/ncurses/ncurses.html"
SRC_URI="mirror://gnu/ncurses/${P}.tar.gz"

LICENSE="MIT"
SLOT="5"
KEYWORDS="x86 ppc sparc sparc64 alpha"

DEPEND="virtual/glibc"

src_compile() {

	[ -z "${DEBUGBUILD}" ] && myconf="${myconf} --without-debug"

	econf \
		--libdir=/lib \
		--disable-termcap \
		--with-shared \
		--with-rcs-ids \
		${myconf} || die "configure failed"

	emake || die "parallel make failed"
}

src_install() {

	make DESTDIR=${D} install || die "make install failed"

	# Move static and extraneous ncurses libraries out of /lib
	cd ${D}/lib
	dodir /usr/lib
	mv libform* libmenu* libpanel* ${D}/usr/lib
	mv *.a ${D}/usr/lib

	# With this fix, the default xterm has color as it should
	cd ${D}/usr/share/terminfo/x
	mv xterm xterm.orig
	dosym xterm-color /usr/share/terminfo/x/xterm

	if [ -n "`use build`" ]
	then
		cd ${D}
		rm -rf usr/share/man
		cd usr/share/terminfo
		cp -a l/linux n/nxterm v/vt100 ${T}
		rm -rf *
		mkdir l x v
		cp -a ${T}/linux l
		cp -a ${T}/nxterm x/xterm
		cp -a ${T}/vt100 v
		#bash compilation requires static libncurses libraries, so
		#this breaks the "build a new build image" system.  We now
		#need to remove libncurses.a from the build image manually.
		#rm *.a
	else
		cd ${S}
		dodoc ANNOUNCE MANIFEST NEWS README* TO-DO
		dodoc doc/*.doc
		dohtml -r doc/html/
	fi
}

