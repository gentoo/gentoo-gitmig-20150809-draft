# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Spider  <spider.gentoo@darkmere.wanfear.com>
# /space/gentoo/cvsroot/gentoo-x86/dev-libs/glib/glib-1.3.14.ebuild,v 1.1 2002/02/20 22:11:06 gbevin Exp

# ACONFVER=2.52f
# AMAKEVER=1.5b
# Source inherit.eclass and inherit AutoTools
# . /usr/portage/eclass/inherit.eclass  || die
# inherit autotools 
SLOT="1"
S=${WORKDIR}/${P}
DESCRIPTION="Gnome Accessibility Toolkit"
SRC_URI="ftp://ftp.gtk.org/pub/gtk/v2.0/${P}.tar.bz2"
HOMEPAGE="http://developer.gnome.org/projects/gap/"

DEPEND=">=dev-util/pkgconfig-0.12.0
		>=dev-libs/glib-2.0.1
		doc? ( >=dev-util/gtk-doc-0.9-r2 )"

src_compile() {
	libtoolize --copy --force
	local myconf
	 use doc && myconf="${myconf} --enable-gtk-doc" || myconf="${myconf} --disable-gtk-doc"
	 
	./configure --host=${CHOST} \
		    --prefix=/usr \
			--sysconfdir=/etc \
		    --infodir=/usr/share/info \
		    --mandir=/usr/share/man \
			${myconf} \
		    --enable-debug || die
## Since glib fails with debug, we debug here too
	emake || die
}

src_install() {
	make prefix=${D}/usr \
		sysconfdir=${D}/etc \
		infodir=${D}/usr/share/info \
		mandir=${D}/usr/share/man \
		install || die
    
	dodoc AUTHORS ChangeLog COPYING README* INSTALL NEWS 
}





