# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-p2p/gnapster/gnapster-1.5.0-r2.ebuild,v 1.5 2002/07/26 05:01:52 gerk Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A napster client for GTK/GNOME"
SRC_URI="http://jasta.gotlinux.org/files/${P}.tar.gz"
HOMEPAGE="http://jasta.gotlinux.org/gnapster.html"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc"

DEPEND="=x11-libs/gtk+-1.2*
	gnome? ( >=gnome-base/gnome-libs-1.4.1.2-r1 )
	gtk? ( >=media-libs/gdk-pixbuf-0.11.0-r1 )"

src_compile() {
	local myconf

	use nls || myconf="${myconf} --disable-nls"

	use gnome 	\
		&& myconf="${myconf} --with-gnome"	\
		|| myconf="${myconf} --disable-gnome"
	
	use gtk	|| myconf="${myconf} --disable-gdk-pixbuf --disable-gtktest"


	./configure --host=${CHOST}					\
		--prefix=/usr					\
		--sysconfdir=/etc					\
		--localstatedir=/var/lib				\
		${myconf} || die

	emake || die
}

src_install () {
	make prefix=${D}/usr 						\
		sysconfdir=${D}/etc					\
		localstatedir=${D}/var/lib					\
		install || die

	dodoc AUTHORS COPYING README* TODO NEWS
}
