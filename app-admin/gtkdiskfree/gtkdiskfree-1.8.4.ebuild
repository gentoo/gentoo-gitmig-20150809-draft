# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/gtkdiskfree/gtkdiskfree-1.8.4.ebuild,v 1.7 2003/04/18 18:10:50 avenj Exp $

DESCRIPTION="shows free space on your mounted filesystems"
HOMEPAGE="http://gtkdiskfree.tuxfamily.org/"
SRC_URI="http://gtkdiskfree.tuxfamily.org/src_tgz/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc"
IUSE="nls"

DEPEND="=x11-libs/gtk+-1.2*
	=dev-libs/glib-1.2*
	nls? ( sys-devel/gettext )"

src_compile() {
	econf `use_enable nls` || die
	emake all || die "emake failed"
}

src_install() {
	einstall DESTDIR=${D} || die
	dodoc AUTHORS ChangeLog NEWS README THANKS TODO
}
