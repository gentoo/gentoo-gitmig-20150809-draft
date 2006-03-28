# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kopete/kopete-3.5.1.ebuild,v 1.3 2006/03/28 00:31:09 agriffis Exp $

KMNAME=kdenetwork
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE multi-protocol IM client"
HOMEPAGE="http://kopete.kde.org/"

KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="sametime ssl xmms"

DEPEND="dev-libs/libxslt
	dev-libs/libxml2
	>=dev-libs/glib-2
	sametime? ( =net-libs/meanwhile-0.4* )
	xmms? ( media-sound/xmms )"
RDEPEND="$DEPEND
	ssl? ( app-crypt/qca-tls )
	!net-im/kopete"

src_compile() {
	# External libgadu support - doesn't work, kopete requires a specific development snapshot of libgadu.
	# Maybe we can enable it in the future.
	# The nowlistening plugin has xmms support.
	local myconf="$(use_enable sametime sametime-plugin)
	              $(use_with xmms) --without-external-libgadu"

	kde-meta_src_compile
}
