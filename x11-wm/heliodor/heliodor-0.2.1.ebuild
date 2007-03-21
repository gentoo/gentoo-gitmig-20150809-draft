# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/heliodor/heliodor-0.2.1.ebuild,v 1.1 2007/03/21 03:11:58 tsunam Exp $

DESCRIPTION="Beryl Metacity Window Decorator"
HOMEPAGE="http://beryl-project.org"
SRC_URI="http://releases.beryl-project.org/${PV}/${P}.tar.bz2"
RESTRICT="mirror"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2.8.0
	>=x11-libs/libwnck-2.14.2
	>=gnome-base/gconf-2
	>=gnome-base/control-center-2.14
	>=x11-wm/metacity-2.16
	~x11-wm/beryl-core-${PV}"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.19
	>=sys-devel/gettext-0.15
	>=dev-util/intltool-0.35"

src_compile() {
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
}
