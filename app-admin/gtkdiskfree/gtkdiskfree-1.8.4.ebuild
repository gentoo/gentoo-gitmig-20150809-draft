# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/gtkdiskfree/gtkdiskfree-1.8.4.ebuild,v 1.11 2004/11/17 16:23:37 vapier Exp $

DESCRIPTION="shows free space on your mounted filesystems"
HOMEPAGE="http://gtkdiskfree.tuxfamily.org/"
SRC_URI="http://gtkdiskfree.tuxfamily.org/src_tgz/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc x86"
IUSE="nls"

DEPEND="=x11-libs/gtk+-1.2*
	=dev-libs/glib-1.2*
	nls? ( sys-devel/gettext )"

src_compile() {
	econf $(use_enable nls) || die
	emake all || die "emake failed"
}

src_install() {
	make install DESTDIR=${D} || die
	dodoc AUTHORS ChangeLog NEWS README THANKS TODO
}
