# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-libs/linc/linc-0.5.0-r2.ebuild,v 1.6 2002/09/05 21:38:33 spider Exp $
inherit debug
inherit libtool


S=${WORKDIR}/${P}
DESCRIPTION="A library to ease the writing of networked applications"
SRC_URI="mirror://gnome/2.0.0/sources/${PN}/${P}.tar.bz2"
HOMEPAGE="http://www.gnome.org/"

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="x86 ppc sparc sparc64"

RDEPEND=">=dev-libs/glib-2.0.4-r1
	>=dev-libs/openssl-0.9.6"

DEPEND="${RDEPEND}
	doc? ( >=dev-util/gtk-doc-0.9-r2 )
	>=dev-util/pkgconfig-0.12.0"
	  
src_compile() {
	elibtoolize
	local myconf
	use doc && myconf="${myconf} --enable-gtk-doc" || myconf="${myconf} --disable-gtk-doc"

	# if this is disabled (use) ORBit2 will fail to build. Just force it on	
	myconf="${myconf} --with-openssl"        
	./configure --host=${CHOST} \
		--prefix=/usr \
		--sysconfdir=/etc \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		${myconf} \
		--enable-debug=yes || die
	emake || die
}

src_install() {
	make prefix=${D}/usr \
		sysconfdir=${D}/etc \
		infodir=${D}/usr/share/info \
		mandir=${D}/usr/share/man \
		install || die
    
 	dodoc AUTHORS ChangeLog COPYING HACKING MAINTAINERS README* INSTALL NEWS TODO
}
