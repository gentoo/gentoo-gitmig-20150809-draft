# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-nds/cpu/cpu-1.3.100.ebuild,v 1.1 2003/07/08 00:53:41 woodchip Exp $

DESCRIPTION="LDAP User Management utilities {user,group}add {user,group}mod"
HOMEPAGE="http://cpu.sourceforge.net/"
SRC_URI="mirror://sourceforge/cpu/${P}.tar.bz2"
SLOT="0"
IUSE=""
KEYWORDS="~x86"
LICENSE="GPL-2"
DEPEND="net-nds/openldap"

src_compile() {
	#NB: Apparently --with-passwd doesnt work yet, but this
	#ebuild should get updated to build it when it does.
	./configure \
		--prefix=/usr \
		--with-ldap=/usr \
		--without-passwd \
		--sysconfdir=/etc \
		--with-libcrack=/usr \
		--mandir=/usr/share/man \
		--infodir=/usr/share/info || die "bad ./configure"

	emake || die "compile problem"
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README TODO
}
