# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/orage/orage-4.4.3.ebuild,v 1.3 2008/12/06 19:41:12 darkside Exp $

EAPI=1

DESCRIPTION="Calendar suite for Xfce4"
HOMEPAGE="http://www.xfce.org/projects/orage"
SRC_URI="mirror://xfce/xfce-${PV}/src/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ~mips ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="debug nls"

RDEPEND=">=dev-libs/glib-2.6:2
	>=x11-libs/gtk+-2.6:2
	>=xfce-base/libxfce4mcs-4.4
	>=xfce-base/libxfce4util-4.4
	>=xfce-base/libxfcegui4-4.4
	>=xfce-base/xfce4-panel-4.4"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/intltool
	sys-devel/gettext"

src_compile() {
	econf \
		--disable-dependency-tracking \
		$(use_enable debug) \
		$(use_enable nls)
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README
}
