# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Leo Lipelis <aeoo@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-misc/gentoo/gentoo-0.11.22.ebuild,v 1.1 2002/03/21 08:16:22 seemant Exp $


S=${WORKDIR}/${P}
DESCRIPTION="A modern GTK+ based filemanager for any WM"
SRC_URI="http://prdownloads.sourceforge.net/gentoo/${P}.tar.gz"
HOMEPAGE="http://www.obsession.se/gentoo/"

DEPEND=">=x11-libs/gtk+-1.2.0"

src_compile() {
	./configure \
		--build=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		--sysconfdir=/etc/gentoo || die "./configure failed"
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
}
