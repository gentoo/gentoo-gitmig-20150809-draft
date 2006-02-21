# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/kopete/kopete-0.12_alpha1.ebuild,v 1.1 2006/02/21 14:56:59 flameeyes Exp $

inherit kde eutils

MY_P="${P/_/-}"

DESCRIPTION="KDE multi-protocol IM client"
HOMEPAGE="http://kopete.kde.org/"
LICENSE="GPL-2"

KEYWORDS="~amd64"
IUSE="sametime ssl xmms"

SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.bz2"

S="${WORKDIR}/${MY_P}"

DEPEND="dev-libs/libxslt
	dev-libs/libxml2
	>=dev-libs/glib-2
	sametime? ( =net-libs/meanwhile-0.4* )
	xmms? ( media-sound/xmms )"
RDEPEND="$DEPEND
	ssl? ( app-crypt/qca-tls )
	!kde-base/kopete"

need-kde 3.4

src_compile() {
	# External libgadu support - doesn't work, kopete requires a specific development snapshot of libgadu.
	# Maybe we can enable it in the future.
	# The nowlistening plugin has xmms support.
	local myconf="$(use_enable sametime sametime-plugin)
	              $(use_with xmms) --without-external-libgadu"

	kde_src_compile
}
