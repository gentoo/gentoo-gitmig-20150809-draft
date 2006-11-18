# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/gnapster/gnapster-1.5.0-r2.ebuild,v 1.15 2006/11/18 04:39:10 compnerd Exp $

inherit gnuconfig

IUSE="nls"

DESCRIPTION="A napster client for GTK/GNOME"
SRC_URI="mirror://sourceforge/gnapster/${P}.tar.gz"
HOMEPAGE="http://sourceforge.net/projects/gnapster/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc amd64"

DEPEND="=x11-libs/gtk+-1.2*"

src_compile() {
	gnuconfig_update

	local myconf

	use nls || myconf="${myconf} --disable-nls"

	myconf="${myconf} --disable-gnome"
	myconf="${myconf} --disable-gdk-pixbuf --disable-gtktest"


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
