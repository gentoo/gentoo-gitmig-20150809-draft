# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/linc/linc-0.7.0.ebuild,v 1.3 2002/12/03 14:46:00 nall Exp $

IUSE="doc ssl"

inherit libtool gnome.org debug

S=${WORKDIR}/${P}
DESCRIPTION="A library to ease the writing of networked applications"
HOMEPAGE="http://www.gnome.org/"

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="x86 ~ppc"

RDEPEND=">=dev-libs/glib-2
	ssl? ( dev-libs/openssl )"

DEPEND="${RDEPEND}
	doc? ( >=dev-util/gtk-doc-0.9-r2 )
	>=dev-util/pkgconfig-0.12.0"
	  
src_compile() {
	elibtoolize
	local myconf
	use doc \
		&& myconf="${myconf} --enable-gtk-doc" \
		|| myconf="${myconf} --disable-gtk-doc"
	use ssl \
		&& myconf="${myconf} --with-openssl" \
		|| myconf="${myconf} --without-openssl"

	econf ${myconf} || die
	emake || die
}

src_install() {
	einstall || die
    
 	dodoc AUTHORS ChangeLog COPYING HACKING MAINTAINERS README* NEWS TODO
}
