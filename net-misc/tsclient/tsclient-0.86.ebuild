# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/tsclient/tsclient-0.86.ebuild,v 1.4 2003/02/13 15:09:03 vapier Exp $

DESCRIPTION="Gtk2 frontend for rdesktop"
HOMEPAGE="http://www.gnomepro.com/tsclient"
SRC_URI="http://www.gnomepro.com/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~sparc"

IUSE=""

DEPEND=">=x11-libs/gtk+-2*
	>=net-misc/rdesktop-1.1.0
	>=dev-libs/glib-2*
	>=gnome-base/gnome-panel-2*"

#RDEPEND=""

S="${WORKDIR}/${P}"

src_compile() {
	econf \
	    --libexecdir=/usr/lib
	emake || die
}

src_install() {
	make DESTDIR=${D} install

	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README VERSION   
}
