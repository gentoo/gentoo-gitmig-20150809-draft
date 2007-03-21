# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/beryl-settings/beryl-settings-0.2.1.ebuild,v 1.1 2007/03/21 02:59:31 tsunam Exp $

DESCRIPTION="Beryl Window Decorator Settings"
HOMEPAGE="http://beryl-project.org"
SRC_URI="http://releases.beryl-project.org/${PV}/${P}.tar.bz2"
RESTRICT="mirror"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

RDEPEND="~x11-misc/beryl-settings-bindings-${PV}
	dev-python/pygtk
	>=gnome-base/librsvg-2.16.1"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.19
	>=sys-devel/gettext-0.15
	>=dev-util/intltool-0.35"

src_compile() {
	econf || die "econf failed"
	emake || die "make failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
}
