# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/ncurses/ncurses-5.3-r1.ebuild,v 1.19 2004/01/16 07:30:51 kumba Exp $

inherit eutils flag-o-matic
filter-flags -fno-exceptions

DESCRIPTION="Linux console display library"
HOMEPAGE="http://www.gnu.org/software/ncurses/ncurses.html"
SRC_URI="mirror://gnu/ncurses/${P}.tar.gz"

LICENSE="MIT"
SLOT="5"
KEYWORDS="x86 ppc sparc alpha hppa ~arm mips"
IUSE="debug"

DEPEND="virtual/glibc"

src_compile() {
	[ `use debug` ] && myconf="${myconf} --without-debug"

	# From version 5.3, ncurses also build c++ bindings, and as
	# we do not have a c++ compiler during bootstrap, disable
	# building it.  We will rebuild ncurses after gcc's second
	# build in bootstrap.sh.
	# <azarah@gentoo.org> (23 Oct 2002)
	( use build || use bootstrap ) \
		&& myconf="${myconf} --without-cxx --without-cxx-binding --without-ada"

	econf \
		--libdir=/lib \
		--disable-termcap \
		--with-shared \
		--with-rcs-ids \
		--without-ada \
		${myconf} || die "configure failed"

	# do not work with -j2 on P4 - <azarah@gentoo.org> (23 Oct 2002)
	make || die "make failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"

	# Move static and extraneous ncurses libraries out of /lib
	cd ${D}/lib
	dodir /usr/lib
	mv libform* libmenu* libpanel* ${D}/usr/lib
	mv *.a ${D}/usr/lib
	# bug #4411
	gen_usr_ldscript libncurses.so

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

pkg_postinst() {
	# Old ncurses may still be around from old build tbz2's.
	rm -f /lib/libncurses.so.5.2
	rm -f /usr/lib/lib{form,menu,panel}.so.5.2
}
