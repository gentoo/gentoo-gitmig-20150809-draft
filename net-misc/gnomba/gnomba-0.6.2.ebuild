# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/gnomba/gnomba-0.6.2.ebuild,v 1.10 2004/04/09 00:56:30 mr_bones_ Exp $

DESCRIPTION="Gnome Samba Browser"
HOMEPAGE="http://gnomba.sourceforge.net"
SRC_URI="http://gnomba.sourceforge.net/src/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc"
IUSE="nls"

RDEPEND="gnome-base/gnome-libs"
DEPEND="${RDEPEND}
	virtual/glibc"

src_compile() {
	./configure \
		$(use_enable nls) \
		--prefix=/usr \
		--host=${CHOST} \
		--mandir=/usr/share/man || die "configure failed"
	emake || die "emake failed"
}

src_install() {
	#remove control chars from desktop file
	mv gnomba.desktop gnomba.desktop.bad
	tr -d '\015' < gnomba.desktop.bad > gnomba.desktop
	make prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		install || die "make install failed"

}
