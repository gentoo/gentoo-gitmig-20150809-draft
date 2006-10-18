# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/scim-bridge/scim-bridge-0.4.5.ebuild,v 1.2 2006/10/18 13:03:26 corsair Exp $

inherit qt3

DESCRIPTION="Yet another IM-client of SCIM"
HOMEPAGE="http://www.scim-im.org/projects/scim_bridge"
SRC_URI="mirror://sourceforge/scim/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc64 ~x86"
IUSE="gtk qt3"

DEPEND=">=app-i18n/scim-1.4.0
	gtk? (
		>=x11-libs/gtk+-2.2
		>=x11-libs/pango-1.1
	)
	qt3? (
		$(qt_min_version 3.3.4)
		>=x11-libs/pango-1.1
	)"

src_compile() {
	econf \
		$(use_enable gtk gtk2-immodule) \
		$(use_enable qt3 qt3-immodule) || die
	emake || die
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"

	dodoc AUTHORS ChangeLog NEWS README
}

pkg_postinst() {
	einfo
	einfo "If you would like to use ${PN} as default instead of scim, set"
	einfo " $ export GTK_IM_MODULE=scim-bridge"
	einfo
}
