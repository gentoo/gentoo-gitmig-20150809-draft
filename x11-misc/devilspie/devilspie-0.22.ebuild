# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/devilspie/devilspie-0.22.ebuild,v 1.10 2011/03/21 22:35:23 nirbheek Exp $

EAPI=2
inherit autotools

DESCRIPTION="A Window Matching utility similar to Sawfish's Matched Windows feature"
HOMEPAGE="http://www.burtonini.com/blog/computers/devilspie"
SRC_URI="http://www.burtonini.com/computing/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ppc sparc x86 ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND=">=dev-libs/glib-2.10
	x11-libs/gtk+:2
	>=x11-libs/libwnck-2.10:1"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/intltool
	sys-devel/gettext
	gnome-base/gnome-common" # Required by eautoreconf

src_prepare() {
	sed -i -e "s:\(/usr/share/doc/devilspie\):\1-${PVR}:" devilspie.1 || die
	sed -i -e '/-DG.*_DISABLE_DEPRECATED/d' src/Makefile.am || die
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README TODO
	keepdir /etc/devilspie
}
