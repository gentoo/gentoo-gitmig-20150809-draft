# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/gnomba/gnomba-0.6.2.ebuild,v 1.9 2004/03/19 10:10:00 mr_bones_ Exp $

DESCRIPTION="Gnome Samba Browser"
SRC_URI="http://gnomba.sourceforge.net/src/${P}.tar.gz"
HOMEPAGE="http://gnomba.sourceforge.net"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc"
IUSE=""

DEPEND="virtual/glibc
		gnome-base/gnome-libs"

RDEPEND="gnome-base/gnome-libs"

src_compile()
{
	./configure --prefix=/usr --host=${CHOST} --mandir=/usr/share/man || die
	emake || die "emake failed"
}

src_install()
{
	#remove control chars from desktop file
	mv gnomba.desktop gnomba.desktop.bad
	tr -d '\015' < gnomba.desktop.bad > gnomba.desktop

	make prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		install || die
}
