# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Daniel Robbins <drobbins@gentoo.org>
# /space/gentoo/cvsroot/gentoo-x86/sys-apps/mosix-user/mosix-user-1.5.2.ebuild,v 1.4 2001/11/25 02:40:12 drobbins Exp

NV=1.0.9-2
S=${WORKDIR}/icewm-1.0.9
DESCRIPTION="Ice Window Manager"
SRC_URI="prdownloads.sourceforge.net/${PN}/${PN}-${NV}.tar.gz"
HOMEPAGE="www.icewm.org"

DEPEND="virtual/x11
	nls? ( >=sys-devel/gettext-0.10.40 )
	imlib? ( >=media-libs/imlib-1.9.10-r1 )"

src_unpack(){
	unpack ${A}
	cd ${S}

	# icewm's doc dir layout is un-gentoo-like.  To fix it, we have
	# "make install" skip the docs install, and do it ourselves.  That also
	# means we have to adjust the Makefile so that it can find the help files
	# when you choose the 'help' item out of its menu.
	t=src/Makefile
	cp $t $t.orig
	sed 's:icewm-$(VERSION)/::' $t.orig > $t
}

src_compile(){
	use nls   && myconf="$myconf --enable-nls" \
	          || myconf="$myconf --disable-nls"
	use imlib && myconf="$myconf --with-imlib" \
	          || myconf="$myconf --without-imlib"
	./configure \
		--build=${CHOST} \
		--prefix=/usr \
		--with-libdir=/usr/lib/icewm \
		--with-cfgdir=/etc/icewm \
		--with-docdir=/usr/share/doc/${PF}/html \
		$myconf || die "configure failed"
	emake || die "emake failed"
}

src_install(){
	make \
		prefix=${D}/usr \
		LIBDIR=${D}/usr/lib/icewm \
		CFGDIR=${D}/etc/icewm \
		DOCDIR=${S}/dummy \
		install || die "make install failed"
	dodoc AUTHORS BUGS CHANGES COPYING FAQ PLATFORMS README* TODO VERSION
	dohtml -a html,sgml doc/*
	
	exeinto /etc/X11/Sessions
	doexe $FILESDIR/icewm
}
