# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xfkc/xfkc-0.2.ebuild,v 1.4 2008/11/08 17:09:06 armin76 Exp $

DESCRIPTION="a keyboard layout configuration tool"
HOMEPAGE="http://gauvain.tuxfamily.org/code/xfkc.html"
SRC_URI="http://gauvain.tuxfamily.org/code/archive/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="debug nls"

RDEPEND=">=xfce-base/libxfce4util-4.4
	>=xfce-base/libxfcegui4-4.4
	>=x11-libs/libxklavier-3"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	nls? ( dev-util/intltool
		sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	cd "${S}"

	echo xfce-xfkc-settings.desktop.in >> po/POTFILES.skip
}

src_compile() {
	econf --disable-dependency-tracking \
		$(use_enable nls) $(use_enable debug)
	emake || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog README
}
