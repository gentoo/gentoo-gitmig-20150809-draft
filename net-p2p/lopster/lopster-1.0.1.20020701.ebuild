# Copyright 2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-p2p/lopster/lopster-1.0.1.20020701.ebuild,v 1.1 2002/07/01 15:56:41 seemant Exp $

S=${WORKDIR}/${PN}
DESCRIPTION="A Napster Client using GTK"
SRC_URI="http://www.ibiblio.org/pub/Linux/distributions/gentoo/distfiles/${P}.tar.bz2"
HOMEPAGE="http://lopster.sourceforge.net"
SLOT="0"
LICENSE="GPL-2"

DEPEND="=x11-libs/gtk+-1.2*"

RDEPEND="nls? ( sys-devel/gettext )"

src_compile() {
	local myconf

	./autogen.sh
	mv po/Makevars.template po/Makevars

	automake m4/Makefile
	aclocal -I m4

	cp configure.in configure.in.orig
	sed "s:\(AM_GNU_GETTEXT\):\1([external]):" \
		configure.in.orig > configure.in

	myconf="--disable-nls"

	econf ${myconf} || die

	cp Makefile Makefile.orig
	sed "s:^SUBDIRS.*:SUBDIRS = m4 src po:" \
		Makefile.orig > Makefile

	emake || die

}

src_install () {

	einstall || die
	dodoc AUTHORS BUGS README ChangeLog NEWS TODO
}

