# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/dc-gui/dc-gui-0.65.ebuild,v 1.4 2003/02/13 15:17:54 vapier Exp $

S=${WORKDIR}/${P/-/_}
DESCRIPTION="GUI for DCTC"
SRC_URI="http://ac2i.tzo.com/dctc/${P/-/_}.tar.gz"
HOMEPAGE="http://ac2i.tzo.com/dctc/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc"
IUSE="nls"

DEPEND="=dev-libs/glib-1.2*
	=gnome-base/gnome-libs-1.4*
	=sys-libs/db-3.2*
	=x11-libs/gtk+-1.2*
	~net-p2p/dctc-0.83.8"
RDEPEND="nls? ( sys-devel/gettext )"

src_compile() {
	local myconf="--with-gnome"

	use nls \
		&& myconf="${myconf} --enable-nls" \
		|| myconf="${myconf} --disable-nls"

	econf ${myconf}
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc ABOUT-NLS AUTHORS COPYING ChangeLog INSTALL NEWS README TODO
}
