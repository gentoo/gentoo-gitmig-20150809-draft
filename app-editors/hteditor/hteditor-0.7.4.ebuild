# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/hteditor/hteditor-0.7.4.ebuild,v 1.7 2004/10/05 12:19:43 pvdabeel Exp $

DESCRIPTION="editor for executable files"
HOMEPAGE="http://hte.sourceforge.net/"
SRC_URI="mirror://sourceforge/hte/ht-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc -alpha"
IUSE=""

DEPEND="virtual/libc"

S="${WORKDIR}/ht-${PV}"

src_compile() {
	chmod +x configure
	./configure --prefix=/usr --sysconfdir=/etc || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS KNOWNBUGS TODO README
	dohtml doc/ht.html
	doinfo doc/*.info
}
