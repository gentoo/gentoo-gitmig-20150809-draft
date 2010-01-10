# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/devilspie/devilspie-0.22.ebuild,v 1.7 2010/01/10 18:29:47 fauli Exp $

DESCRIPTION="A Window Matching utility similar to Sawfish's Matched Windows feature"
HOMEPAGE="http://www.burtonini.com/blog/computers/devilspie"
SRC_URI="http://www.burtonini.com/computing/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ppc sparc x86 ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND=">=dev-libs/glib-2.10
	>=x11-libs/gtk+-2
	>=x11-libs/libwnck-2.10"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/intltool
	sys-devel/gettext"

src_unpack() {
	unpack ${A}
	sed -i -e "s:\(/usr/share/doc/devilspie\):\1-${PVR}:" "${S}"/devilspie.1
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog NEWS README TODO
	keepdir /etc/devilspie
}
