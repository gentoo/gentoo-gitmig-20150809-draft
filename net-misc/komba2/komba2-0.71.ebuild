# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Bart Verwilst <verwilst@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-misc/komba2/komba2-0.71.ebuild,v 1.1 2001/11/19 23:36:37 verwilst Exp $

S=${WORKDIR}/${P}

DESCRIPTION="Windows(Samba) network administrating tool for KDE"
HOMEPAGE="http://zeus.fh-brandenburg.de/~schwanz/php/komba.php3"

DEPENDS=">=virtual/glibc
	>=x11-libs/qt-x11-2.2.3
	>=kde-base/kdelibs-2.1
	>=kde-base/kdebase-2.1
	>=net-fs/samba-2.2"

SRC_URI="http://zeus.fh-brandenburg.de/~schwanz/files/${P}.tar.gz"

src_compile() {

	./configure --prefix=/usr --host=${CHOST} || die
	make || die

}

src_install() {

	make destdir=${D}/usr install || die

}
