# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/dc-gui/dc-gui-0.66.ebuild,v 1.2 2003/04/24 13:45:00 vapier Exp $

S=${WORKDIR}/${P/-/_}
DESCRIPTION="GUI for DCTC (GTK1 version)"
SRC_URI="http://ac2i.tzo.com/dctc/${P/-/_}.tar.gz"
HOMEPAGE="http://ac2i.tzo.com/dctc/"

SLOT="1"
LICENSE="GPL-2"
KEYWORDS="x86 ppc"
IUSE="nls"

DEPEND="=dev-libs/glib-1*
	=gnome-base/gnome-libs-1.4*
	=sys-libs/db-3.2*
	=x11-libs/gtk+-1*
	>=net-p2p/dctc-0.83.8"
RDEPEND="nls? ( sys-devel/gettext )"

src_compile() {
	econf --with-gnome `use_enable nls` || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc ABOUT-NLS AUTHORS ChangeLog NEWS README TODO
}
