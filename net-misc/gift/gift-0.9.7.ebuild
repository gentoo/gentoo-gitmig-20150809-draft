# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Bart Verwilst <verwilst@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-misc/gift/gift-0.9.7.ebuild,v 1.1 2001/12/07 12:44:51 verwilst Exp $

S="${WORKDIR}/giFT-0.9.7"

DEPEND="virtual/glibc"

SRC_URI="http://prdownloads.sourceforge.net/gift/giFT-0.9.7.tar.gz"

src_compile() {

	./configure --prefix=/usr || die
	emake || die

}

src_install() {

	make DESTDIR=${D} install || die

}
