# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Leo Lipelis <aeoo@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-misc/gentoo/gentoo-0.11.18.ebuild,v 1.1 2002/02/02 08:09:15 aeoo Exp $


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
	cd ${D}/etc/gentoo
	mv gentoorc gentoorc.orig
	sed -e 's:\(<path>"\)icons\("</path>\):\1/usr/share/gentoo/icons\2:' \
		gentoorc.orig > gentoorc
	rm gentoo.orig
}
