# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/siefs/siefs-0.4.ebuild,v 1.3 2005/03/25 14:39:41 blubb Exp $

DESCRIPTION="Siemens FS"
HOMEPAGE="http://weidner.in-bad-schmiedeberg.de/computer/linux/debian/siefs/"
SRC_URI="http://weidner.in-bad-schmiedeberg.de/computer/linux/debian/siefs/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE=""

DEPEND="<sys-fs/fuse-1.9"

src_unpack() {
	unpack ${A}
	cd ${S}/siefs
	cp Makefile.in Makefile.in.orig
	sed -e "s:-rm -f /sbin/mount.siefs:-mkdir \$(DESTDIR)/sbin/:" Makefile.in.orig > Makefile.in.2 || die "sed 1 failed"
	sed -e "s:-ln -s \$(DESTDIR)\$(bindir)/siefs /sbin/mount.siefs:-ln -s ..\$(bindir)/siefs \$(DESTDIR)/sbin/mount.siefs:" Makefile.in.2 > Makefile.in || die "sed 2 failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
	dodoc README NEWS AUTHORS
}
