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
DESCRIPTION="Text rendering and Layout library"
SRC_URI="ftp://ftp.gtk.org/pub/gtk/v2.0/${P}.tar.bz2"
HOMEPAGE="http://www.pango.org/"

DEPEND=">=dev-libs/glib-2.0.1
		virtual/x11
		>=dev-util/pkgconfig-0.12.0
		>=app-text/openjade-1.3-r2
		>=app-text/docbook-sgml-dtd-4.1
		>=app-text/sgml-common-0.6.1
		>=app-text/docbook-sgml-1.0
		>=media-libs/freetype-2.0.8
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
# turn on debug again, glib dislikes not having it.
	emake || die
}

src_install() {
	make prefix=${D}/usr \
		sysconfdir=${D}/etc \
		infodir=${D}/usr/share/info \
		mandir=${D}/usr/share/man \
		install || die
	rm ${D}/etc/pango/pango.modules


 	dodoc AUTHORS ChangeLog COPYING README* INSTALL NEWS NEWS.pre-1-3 TODO*
}

pkg_postinst() {
	pango-querymodules >/etc/pango/pango.modules
}

