# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/gnomba/gnomba-0.6.2.ebuild,v 1.8 2003/09/05 22:01:48 msterret Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Gnome Samba Browser"
SRC_URI="http://gnomba.sourceforge.net/src/${P}.tar.gz"
HOMEPAGE="http://gnomba.sourceforge.net"
LICENSE="GPL-2"
KEYWORDS="x86 sparc "
SLOT="0"

DEPEND="virtual/glibc
		gnome-libs"

RDEPEND="gnome-libs"

src_unpack ()
{
	unpack ${A}
	cd ${S}
}

src_compile ()
{
	./configure --prefix=/usr --host=${CHOST} --mandir=/usr/share/man || die
	emake || die
}

src_install ()
{
	#remove control chars from desktop file
	mv gnomba.desktop gnomba.desktop.bad
	tr -d '\015' < gnomba.desktop.bad > gnomba.desktop

	make prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		install || die
}
