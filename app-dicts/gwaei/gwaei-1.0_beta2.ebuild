# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/gwaei/gwaei-1.0_beta2.ebuild,v 1.1 2009/05/03 05:30:53 matsuu Exp $

inherit autotools eutils gnome2-utils

MY_P="${P/_beta/b}"
DESCRIPTION="Japanese-English Dictionary for GNOME"
HOMEPAGE="http://gwaei.sourceforge.net/"
SRC_URI="mirror://sourceforge/gwaei/${MY_P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gnome nls"

RDEPEND=">=net-misc/curl-7.18
	>=dev-libs/glib-2.16.5
	gnome? (
		>=gnome-base/gconf-2
		>=gnome-base/libgnome-2.20
		>=x11-libs/gtk+-2.12
		>=x11-libs/libsexy-0.1.11
	)
	nls? ( virtual/libintl )"
DEPEND="${RDEPEND}
	nls? ( >=sys-devel/gettext-0.17 )
	dev-util/pkgconfig"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-gentoo.patch"
	eautoreconf
}

src_compile() {
	econf \
		$(use_with gnome) \
		$(use_enable nls) \
		--disable-schemas-install || die
	emake || die
}

src_install() {
	emake DESTDIR="${D}" install || die

	rm -rf "${D}/usr/share/doc/${P}"
	dodoc AUTHORS ChangeLog NEWS README
}
pkg_preinst() {
	if use gnome ; then
		gnome2_gconf_savelist
		gnome2_icon_savelist
	fi
}

pkg_postinst() {
	use gnome && gnome2_gconf_install
}
