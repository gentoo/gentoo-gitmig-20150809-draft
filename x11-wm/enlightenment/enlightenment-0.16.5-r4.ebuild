# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/x11-wm/enlightenment/enlightenment-0.16.5-r4.ebuild,v 1.8 2002/08/13 01:39:22 gerk Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Enlightenment Window Manager"
SRC_URI="ftp://ftp.enlightenment.org/enlightenment/enlightenment/${P}.tar.gz"
HOMEPAGE="http://www.enlightenment.org/"
LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 ppc"

DEPEND=">=media-libs/fnlib-0.5
	>=media-sound/esound-0.2.19
	~media-libs/freetype-1.3.1
	>=gnome-base/libghttp-1.0.9-r1"

RDEPEND="nls? ( sys-devel/gettext )"

src_compile() {

	local myconf
	use nls || myconf="${myconf} --disable-nls"
  
	./configure \
		--host=${CHOST} \
		--enable-fsstd \
		--prefix=/usr \
		--mandir=/usr/share/man \
		--infodir=/usr/share/info \
		${myconf} || die
	emake || die
}

src_install() {
	mv man/Makefile man/Makefile_orig
	sed -e "s:\(DESTDIR\ =\):\1\ ${D}:" man/Makefile_orig > man/Makefile

	# this fixes an issue where enlightenment.install has an incomplete
	# path to the englightenment binary
	mv scripts/${PN}.install.in scripts/${PN}.install.in.orig
	sed 's:\(^EBIN=\).*:\1@prefix@/bin:' \
		scripts/${PN}.install.in.orig > scripts/${PN}.install.in
	
	make prefix=${D}/usr \
		localedir=${D}/usr/share/locale \
		gnulocaledir=${D}/usr/share/locale \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		install || die
  
	doman man/enlightenment.1
	dodoc ABOUT-NLS AUTHORS ChangeLog COPYING FAQ INSTALL NEWS README
	docinto sample-scripts
	dodoc sample-scripts/*
	
	exeinto /etc/X11/Sessions
	doexe $FILESDIR/enlightenment
	
}

