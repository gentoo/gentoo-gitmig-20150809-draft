# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/echo-icon-theme/echo-icon-theme-0.3.89.0_pre20081031.ebuild,v 1.1 2008/10/31 20:43:01 cardoe Exp $

inherit eutils gnome2-utils

DESCRIPTION="SVG icon theme from the Echo Icon project"
HOMEPAGE="https://fedorahosted.org/echo-icon-theme"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="CCPL-Attribution-ShareAlike-3.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RESTRICT="binchecks strip"

RDEPEND=">=x11-misc/icon-naming-utils-0.8.2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S="${WORKDIR}/${PN}-${PV/_pre*}"

src_compile() {
	econf || die "econf failed."
	emake || die "emake failed."
}

src_install() {
	addwrite "/root/.gnome2"
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog
}

pkg_postinst() {
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}
