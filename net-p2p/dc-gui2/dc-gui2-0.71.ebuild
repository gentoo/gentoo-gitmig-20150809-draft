# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/dc-gui2/dc-gui2-0.71.ebuild,v 1.1 2003/03/11 13:24:36 vapier Exp $

S=${WORKDIR}/${P/-/_}
DESCRIPTION="GUI for dctc (GTK2 version)"
SRC_URI="http://ac2i.tzo.com/dctc/${P/-/_}.tar.gz"
HOMEPAGE="http://ac2i.tzo.com/dctc/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"
IUSE="nls pic"

DEPEND="=dev-libs/glib-2*
	=x11-libs/gtk+-2*
	=gnome-base/libgnomeui-2*
	>=sys-libs/db-3.2*
	>=net-p2p/dctc-0.83.8"
RDEPEND="nls? ( sys-devel/gettext )"

src_compile() {
	econf `use_enable nls` `use_with pic` || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	use nls || rm -rf ${D}/usr/share/locale
	dodoc AUTHORS ChangeLog NEWS README TODO
}
