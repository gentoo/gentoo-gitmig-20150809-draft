# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/gmyclient/gmyclient-0.3.ebuild,v 1.1 2002/11/05 14:19:42 nall Exp $

IUSE="nls"

S=${WORKDIR}/${P}
DESCRIPTION="Gnome based mysql client"
SRC_URI="http://${PN}.sourceforge.net/download/${P}.tar.gz"
HOMEPAGE="http://gmyclient.sourceforge.net"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc"

DEPEND="( >=gnome-base/gnome-libs-1.2*
		dev-db/mysql )"

RDEPEND="( >=gnome-base/gnome-libs-1.2* )"

src_compile() {
	local myconf

	if [ -z "`use nls`" ] ; then
		myconf="--disable-nls"
	fi

	econf $myconf || die

	emake || die
}

src_install() {
	make prefix=${D}/usr \
	sysconfdir=${D}/etc \
	localstatedir=${D}/var/lib \
	install || die

	dodoc AUTHORS COPYING ChangeLog NEWS README TODO
}


