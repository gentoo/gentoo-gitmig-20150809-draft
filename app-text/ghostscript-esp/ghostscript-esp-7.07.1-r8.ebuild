# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/ghostscript-esp/ghostscript-esp-7.07.1-r8.ebuild,v 1.12 2006/10/21 11:12:34 grobian Exp $

inherit flag-o-matic eutils toolchain-funcs libtool

DESCRIPTION="ESP Ghostscript -- an enhanced version of GNU Ghostscript with better printer support"
HOMEPAGE="http://www.cups.org/ghostscript.php"
SRC_URI="mirror://sourceforge/espgs/espgs-${PV}-source.tar.bz2
	mirror://gentoo/gs7.07.1-cjk.diff.bz2
	cjk? ( http://www.matsusaka-u.ac.jp/mirror/gs-cjk/adobe-cmaps-200204.tar.gz
		http://www.matsusaka-u.ac.jp/mirror/gs-cjk/acro5-cmaps-2001.tar.gz )"

LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k mips ppc ppc64 s390 sh sparc x86"
IUSE="X cups cjk emacs gtk"

DEP="virtual/libc
	>=media-libs/jpeg-6b
	>=media-libs/libpng-1.2.1
	>=sys-libs/zlib-1.1.4
	X? ( || ( (
			x11-libs/libX11
			x11-libs/libXt )
		virtual/x11 ) )
	gtk? ( >=x11-libs/gtk+-2.0 )
	cups? ( net-print/cups )
	!app-text/ghostscript-gnu
	!app-text/ghostscript-gpl"

RDEPEND="${DEP}
	cjk? ( media-fonts/arphicfonts
		media-fonts/kochi-substitute
		media-fonts/baekmuk-fonts )
	media-fonts/gnu-gs-fonts-std"

DEPEND="${DEP}
	gtk? ( dev-util/pkgconfig )"

#	media-libs/fontconfig"

S=${WORKDIR}/espgs-${PV}

src_unpack() {
	unpack espgs-${PV}-source.tar.bz2

	cd ${S}

	if use cjk ; then
		epatch "${DISTDIR}"/gs7.07.1-cjk.diff.bz2
		epatch ${FILESDIR}/gs7.05.6-kochi-substitute.patch
	fi

	# add fontconfig support (this patch is broken)
	# epatch ${FILESDIR}/gs7.07.1-fontconfig-rh.patch.2.bz2

	# man page patch from absinthe@pobox.com (Dylan Carlson) bug #14150
	epatch ${FILESDIR}/ghostscript-7.05.6.man.patch

	# ijs fPIC patch
	epatch ${FILESDIR}/gs${PV}-ijs.patch

	# pxl dash patch
	epatch ${FILESDIR}/gs7.05.6-gdevpx.patch

	# Makefile.in fixes for DESTDIR support in libijs because
	# einstall borks on multilib systems -- eradicator
	epatch ${FILESDIR}/gs${PV}-destdir.patch
	epatch ${FILESDIR}/gs${PV}-ijsdestdir.patch

	# search path fix
	sed -i -e "s:\$\(gsdatadir\)/lib:/usr/share/ghostscript/7.07/$(get_libdir):"\
	Makefile.in || die "sed failed"
	sed -i -e 's:$(gsdir)/fonts:/usr/share/fonts/default/ghostscript/:' \
	Makefile.in || die "sed failed"

	# insecure tempfile handling
	epatch ${FILESDIR}/gs${PV}-tempfile.patch

	# krgb support (currently broken)
	#( cd src; epatch ${FILESDIR}/gs7.07.1-krgb.patch.gz )

	# Fix the garbage collector on ia64 and ppc
	epatch ${FILESDIR}/gs-fix-gc.patch

	# bug #63435
	epatch ${FILESDIR}/gs${PV}-ps2ps.patch

	# fix dynamic build
	echo '#include "png.h"' >> src/png_.h

	# fix for building with gtk2 instead of gtk1
	if use gtk; then
		sed -i -e "s:gmodule:gmodule-2.0:" configure.ac
		sed -i -e "s:glib-config:pkgconfig:" configure.ac
		sed -i -e "s:gtk-config:pkg-config gtk+-2.0:g" src/unix-dll.mak
		sed -i -e "s:CFLAGS_SO=-fPIC:CFLAGS_SO=-fPIC -I/usr/include/glib-2.0 -I/usr/lib/glib-2.0/include:" Makefile.in
	else
		epatch ${FILESDIR}/gs${PV}-nogtk2.patch
	fi
}

src_compile() {
	local myconf
	myconf="--with-ijs --without-gimp-print"
	use gtk && myconf="${myconf} --with-omni" || myconf="${myconf} --without-omni"

	# bug #56998, only compiled-in fontpath is searched when running 
	# gs -DPARANOIDSAFER out.ps
	myconf="${myconf} --with-fontconfig --with-fontpath=/usr/share/fonts:/usr/share/fonts/ttf/zh_TW:/usr/share/fonts/ttf/zh_CN:/usr/share/fonts/arphicfonts:/usr/share/fonts/ttf/korean/baekmuk:/usr/share/fonts/baekmuk-fonts:/usr/X11R6/lib/X11/fonts/truetype:/usr/share/fonts/kochi-substitute"

	use X && myconf="${myconf} --with-x" \
		|| myconf="${myconf} --without-x"

	use cups && myconf="${myconf} --enable-cups" \
		|| myconf="${myconf} --disable-cups"

	# -O3 will make ghostscript fail when compiling with gcc 3.4
	if [ "`gcc-major-version`" -eq "3" ] && [ "`gcc-minor-version`" -eq "4" ]
	then
		strip-flags
		replace-flags -O? -O2
	fi

	autoconf
	econf ${myconf} || die "econf failed"
	emake -j1 || die "make failed"
	emake so -j1 || die "make failed"

	cd ijs
	econf || die "econf failed"
	emake -j1 || die "make failed"
	cd ..
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	make DESTDIR="${D}" soinstall || die "make install failed"

	rm -fr ${D}/usr/share/ghostscript/7.07/doc || die
	dodoc doc/README doc/COPYING doc/COPYING.LGPL
	dohtml doc/*.html doc/*.htm

	if use emacs; then
		insinto /usr/share/emacs/site-lisp
		doins doc/gsdoc.el
	fi

	if use cjk ; then
		dodir /usr/share/ghostscript/Resource
		dodir /usr/share/ghostscript/Resource/Font
		dodir /usr/share/ghostscript/Resource/CIDFont
		cd ${D}/usr/share/ghostscript/Resource
		unpack adobe-cmaps-200204.tar.gz
		unpack acro5-cmaps-2001.tar.gz
	fi

	# Install ijs
	cd ${S}/ijs
	dodir /usr/bin /usr/include /usr/$(get_libdir)
	# This is broken - there are not even a 'install_prefix'
	# anywhere in ${S}/ijs ...
	#einstall install_prefix=${D}
	#einstall
	#dosed "s:^prefix=.*:prefix=/usr:" /usr/bin/ijs-config
	make DESTDIR="${D}" install || die

	# bug #83876, collision with gcc
	rm -f ${D}/usr/share/man/de/man1/ansi2knr.1
	rm -f ${D}/usr/share/man/man1/ansi2knr.1
}
