# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/gtkdiskfree/gtkdiskfree-1.8.4.ebuild,v 1.1 2002/11/06 06:31:21 blocke Exp $

S=${WORKDIR}/${P}
DESCRIPTION="GtkDiskFree is a program which shows free space on your mounted filesystems"
HOMEPAGE="http://gtkdiskfree.tuxfamily.org/"
SRC_URI="http://gtkdiskfree.tuxfamily.org/src_tgz/${P}.tar.gz"
IUSE=""

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

DEPEND="=x11-libs/gtk+-1.2*
		=dev-libs/glib-1.2*
		nls? ( sys-devel/gettext ) "

src_compile() {
	local myconf

	use nls || myconf="--disable-nls"
	
	econf ${myconf} || die "./configure failed"
	emake all || die "emake failed"
}

src_install() {
	einstall DESTDIR=${D} || die "einstall failed"

	dodoc AUTHORS ChangeLog NEWS README THANKS TODO
}

