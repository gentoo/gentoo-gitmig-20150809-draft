# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-libs/linc/linc-0.1.22.ebuild,v 1.3 2002/07/16 04:54:33 seemant Exp $

# Do _NOT_ strip symbols in the build! Need both lines for Portage 1.8.9+
DEBUG="yes"
RESTRICT="nostrip"
# force debug information
CFLAGS="${CFLAGS} -g"
CXXFLAGS="${CXXFLAGS} -g"

S=${WORKDIR}/${P}
DESCRIPTION="A library to ease the writing of networked applications"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/pre-gnome2/sources/${PN}/${P}.tar.bz2"
HOMEPAGE="http://www.gnome.org/"
SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="x86 -ppc"

RDEPEND=">=dev-libs/glib-2.0.0
	>=dev-libs/openssl-0.9.6"

DEPEND="${RDEPEND}
	doc? ( >=dev-util/gtk-doc-0.9-r2 )
	>=dev-util/pkgconfig-0.12.0"
	  
src_compile() {
#	libtoolize --copy --force
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
