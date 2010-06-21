# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xcave/xcave-2.3.2.ebuild,v 1.2 2010/06/21 15:54:25 ssuominen Exp $

EAPI=2
inherit autotools

DESCRIPTION="View and manage contents of your wine cellar"
HOMEPAGE="http://xcave.free.fr/index-en.php"
SRC_URI="http://${PN}.free.fr/backbone.php?what=download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2.8:2
	>=gnome-base/libglade-2.6
	dev-libs/libxml2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	sys-devel/gettext
	dev-util/intltool"

src_prepare() {
	echo src/xcave_supp.c > po/POTFILES.skip
#	intltoolize --force --copy --automake || die
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc ChangeLog TODO
	rm -rf "${D}"/usr/doc
}
