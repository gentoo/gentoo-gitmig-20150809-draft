# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/hteditor/hteditor-0.7.4.ebuild,v 1.3 2004/05/31 22:12:03 vapier Exp $

DESCRIPTION="editor for executable files"
HOMEPAGE="http://hte.sourceforge.net/"
SRC_URI="mirror://sourceforge/hte/ht-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc -alpha"
IUSE=""

DEPEND="virtual/glibc"

S="${WORKDIR}/ht-${PV}"

src_compile() {
	chmod +x configure
	local myconf="--prefix=/usr --sysconfdir=/etc"
	./configure ${myconf}  || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS KNOWNBUGS TODO README
	dohtml doc/ht.html
	doinfo doc/*.info
}
