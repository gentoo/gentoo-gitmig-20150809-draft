# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/gnapster/gnapster-1.5.0-r2.ebuild,v 1.13 2004/07/09 01:39:30 squinky86 Exp $

inherit gnuconfig

IUSE="nls gtk gnome"

DESCRIPTION="A napster client for GTK/GNOME"
SRC_URI="http://jasta.gotlinux.org/files/${P}.tar.gz"
HOMEPAGE="http://jasta.gotlinux.org/gnapster.html"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc amd64"

DEPEND="=x11-libs/gtk+-1.2*
	gnome? ( >=gnome-base/gnome-libs-1.4.1.2-r1 )
	gtk? ( >=media-libs/gdk-pixbuf-0.11.0-r1 )"

src_compile() {
	gnuconfig_update

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
