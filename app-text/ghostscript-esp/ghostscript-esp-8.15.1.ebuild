# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/ghostscript-esp/ghostscript-esp-8.15.1.ebuild,v 1.2 2006/01/05 22:06:47 genstef Exp $

inherit autotools eutils flag-o-matic

DESCRIPTION="ESP Ghostscript -- an enhanced version of GPL Ghostscript with better printer support"
HOMEPAGE="http://www.cups.org/ghostscript.php"

SRC_URI="http://ftp.easysw.com/pub/ghostscript/${PV}/espgs-${PV}-source.tar.bz2
	cjk? ( http://www.matsusaka-u.ac.jp/mirror/gs-cjk/adobe-cmaps-200204.tar.gz
		http://www.matsusaka-u.ac.jp/mirror/gs-cjk/acro5-cmaps-2001.tar.gz )"

LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sparc ~x86"
IUSE="X cups cjk emacs gtk"

DEP="virtual/libc
	>=media-libs/jpeg-6b
	>=media-libs/libpng-1.2.5
	>=sys-libs/zlib-1.1.4
	>=media-libs/tiff-3.7
	X? ( || ( x11-libs/libXt virtual/x11 ) )
	gtk? ( >=x11-libs/gtk+-2.0 )
	cups? ( >=net-print/cups-1.1.20 )
	omni? ( dev-libs/libxml2 )
	!virtual/ghostscript"

RDEPEND="${DEP}
	cjk? ( media-fonts/arphicfonts
		media-fonts/kochi-substitute
		media-fonts/baekmuk-fonts )
	media-fonts/gnu-gs-fonts-std"

DEPEND="${DEP}
	gtk? ( dev-util/pkgconfig )"

#	media-libs/fontconfig"

PROVIDE="virtual/ghostscript"

S=${WORKDIR}/espgs-8.15.1

src_unpack() {

	unpack ${A}

	cd ${S}

	append-flags "-fPIC"

	epatch ${FILESDIR}/gs-${PV}destdir.patch
	epatch ${FILESDIR}/ghostscript-build.patch
	if use gtk;then
		epatch ${FILESDIR}/ghostscript-gtk2.patch
	fi
	epatch ${FILESDIR}/ghostscript-scripts.patch
	epatch ${FILESDIR}/ghostscript-ps2epsi.patch
	epatch ${FILESDIR}/ghostscript-badc.patch
	epatch ${FILESDIR}/ghostscript-pagesize.patch
	epatch ${FILESDIR}/ghostscript-noopt.patch
	epatch ${FILESDIR}/ghostscript-use-external-freetype.patch
	epatch ${FILESDIR}/ghostscript-split-font-configuration.patch

	# search path fix
	sed -i -e "s:\$\(gsdatadir\)/lib:/usr/share/ghostscript/8.15/$(get_libdir):"\
	Makefile.in || die "sed failed"
	sed -i -e 's:$(gsdir)/fonts:/usr/share/fonts/default/ghostscript/:' \
	Makefile.in || die "sed failed"
	# Add -fPIC to build with AMD64
	sed -i -e 's/CFLAGS=$(GCFLAGS) $(XCFLAGS) $(ACDEFS)/CFLAGS=$(GCFLAGS) $(XCFLAGS) $(ACDEFS) -fPIC/g' src/unix-gcc.mak || die
}

src_compile() {
	local myconf
	myconf="--with-ijs --without-gimp-print"
	use gtk && myconf="${myconf} --with-omni" || myconf="${myconf} --without-omni"

	# gs -DPARANOIDSAFER out.ps
	myconf="${myconf} --with-fontconfig --with-fontpath=/usr/share/fonts:/usr/share/fonts/ttf/zh_TW:/usr/share/fonts/ttf/zh_CN:/usr/share/fonts/arphicfonts:/usr/share/fonts/ttf/korean/baekmuk:/usr/share/fonts/baekmuk-fonts:/usr/X11R6/lib/X11/fonts/truetype:/usr/share/fonts/kochi-substitute"

	use X && myconf="${myconf} --with-x" \
		|| myconf="${myconf} --without-x"

	use cups && myconf="${myconf} --enable-cups" \
		|| myconf="${myconf} --disable-cups"

	eautoreconf
	econf ${myconf} || die "econf failed"
	emake -j1 || die "make failed"
	emake so -j1 || die "make failed"

	cd ijs
	econf || die "econf failed"
	emake -j1 || die "make failed"
	cd ..
}

src_install() {

#	dodir /usr/share/ghostscript
	make DESTDIR="${D}" install || die "make install failed"
	make DESTDIR="${D}" soinstall || die "make install failed"

	rm -fr ${D}/usr/share/ghostscript/8.15/doc || die
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
	einstall install_prefix=${D}
	einstall
	dosed "s:^prefix=.*:prefix=/usr:" /usr/bin/ijs-config
	make DESTDIR="${D}" install || die

	# bug #83876, collision with gcc
	rm -f ${D}/usr/share/man/de/man1/ansi2knr.1
	rm -f ${D}/usr/share/man/man1/ansi2knr.1
}
