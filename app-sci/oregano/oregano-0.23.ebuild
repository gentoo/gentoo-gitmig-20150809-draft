# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/oregano/oregano-0.23.ebuild,v 1.1 2002/06/13 07:35:44 lostlogic Exp $

DESCRIPTION="This is a sample skeleton ebuild file"
HOMEPAGE="http://oregano.codefactory.se/"
LICENSE="GPL-2"
DEPEND="x11-libs/gtk+
	gnome? gnome-base/gnome"
RDEPEND="${DEPEND}"
SRC_URI="ftp://ftp.codefactory.se/pub/CodeFactory/software/oregano/${P}.tar.gz"
S=${WORKDIR}/${P}
SLOT="0"

src_compile() {
	local myconf
	[ `use nls` ] || myconf="${myconf} --disable-nls"
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
}
