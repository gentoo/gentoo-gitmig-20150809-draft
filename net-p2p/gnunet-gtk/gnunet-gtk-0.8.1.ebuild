# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/gnunet-gtk/gnunet-gtk-0.8.1.ebuild,v 1.2 2011/03/28 22:19:02 eva Exp $

EAPI="3"

DESCRIPTION="Graphical front end for GNUnet."
HOMEPAGE="http://gnunet.org/"
SRC_URI="http://gnunet.org/download/${P}.tar.gz"

KEYWORDS="~amd64 ~ppc64 ~x86"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2.6:2
	>=net-p2p/gnunet-${PV}
	gnome-base/libglade:2.0"
DEPEND="${RDEPEND}"

src_configure() {
	econf --with-gnunet=/usr
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
}
