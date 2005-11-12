# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kopete/kopete-3.5.0_rc1.ebuild,v 1.1 2005/11/12 15:49:31 danarmak Exp $

KMNAME=kdenetwork
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE multi-protocol IM client"
HOMEPAGE="http://kopete.kde.org/"

KEYWORDS="~amd64 ~ppc ~x86"
IUSE="sametime ssl xmms"

DEPEND="dev-libs/libxslt
	dev-libs/libxml2
	>=dev-libs/glib-2
	sametime? ( >=net-libs/meanwhile-0.4.2 )
	xmms? ( media-sound/xmms )"
RDEPEND="$DEPEND
	ssl? ( app-crypt/qca-tls )"

src_compile() {
	# External libgadu support - doesn't work, kopete requires a specific development snapshot of libgadu.
	# Maybe we can enable it in the future.
	# The nowlistening plugin has xmms support.
	local myconf="$(use_enable sametime sametime-plugin)
	              $(use_with xmms) --without-external-libgadu"

	kde-meta_src_compile
}
