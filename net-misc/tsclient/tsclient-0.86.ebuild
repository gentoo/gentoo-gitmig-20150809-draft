# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/tsclient/tsclient-0.86.ebuild,v 1.5 2003/02/22 08:27:51 liquidx Exp $

DESCRIPTION="Gtk2 frontend for rdesktop"
HOMEPAGE="http://www.gnomepro.com/tsclient"
SRC_URI="http://www.gnomepro.com/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~sparc"

IUSE=""

DEPEND=">=x11-libs/gtk+-2.0
	>=net-misc/rdesktop-1.1.0
	>=dev-libs/glib-2.0
	>=gnome-base/gnome-panel-2.0"

#RDEPEND=""

S="${WORKDIR}/${P}"

src_compile() {
	econf || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install
	insinto /usr/share/gnome/apps/Internet
	doins ${FILESDIR}/tsclient.desktop
	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README VERSION   
}
