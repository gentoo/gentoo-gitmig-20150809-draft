# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/dc-gui/dc-gui-0.75.ebuild,v 1.3 2003/11/03 23:14:00 vapier Exp $

MY_P=${PN/-/_}2-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="GUI for dctc (GTK2 version)"
HOMEPAGE="http://ac2i.tzo.com/dctc/"
SRC_URI="http://ac2i.tzo.com/dctc/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="2"
KEYWORDS="x86 ppc"
IUSE="nls"

DEPEND="=dev-libs/glib-2*
	=x11-libs/gtk+-2*
	=gnome-base/libgnomeui-2*
	>=sys-libs/db-3.2*
	>=net-p2p/dctc-0.85.4"
RDEPEND="nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	cd ${S}/src
	cp ${FILESDIR}/split_interface_fast.pl .
	perl split_interface_fast.pl || die "could not split interface up"
}

src_compile() {
	econf `use_enable nls` || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	use nls || rm -rf ${D}/usr/share/locale
	dodoc AUTHORS ChangeLog NEWS README TODO
}
