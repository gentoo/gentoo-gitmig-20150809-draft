# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kopete/kopete-3.5.2.ebuild,v 1.3 2006/04/07 11:52:24 flameeyes Exp $

KMNAME=kdenetwork
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE multi-protocol IM client"
HOMEPAGE="http://kopete.kde.org/"

KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="sametime ssl xmms"

# The kernel_linux? ( ) conditional dependencies are for webcams, not supported
# on other kernels AFAIK
BOTH_DEPEND="dev-libs/libxslt
	dev-libs/libxml2
	net-dns/libidn
	>=dev-libs/glib-2
	app-crypt/qca
	sametime? ( =net-libs/meanwhile-0.4* )
	xmms? ( media-sound/xmms )
	|| ( (
		x11-libs/libX11
		x11-libs/libXext
		x11-libs/libXrender
		x11-libs/libXScrnSaver
		) virtual/x11 )
	kernel_linux? ( virtual/opengl )"

RDEPEND="${BOTH_DEPEND}
	ssl? ( app-crypt/qca-tls )"

DEPEND="${BOTH_DEPEND}
	kernel_linux? ( virtual/os-headers )
	|| ( (
			x11-proto/videoproto
			x11-proto/xextproto
			x11-proto/xproto
			kernel_linux? ( x11-libs/libXv )
			x11-proto/scrnsaverproto
		) virtual/x11 )"

src_compile() {
	# External libgadu support - doesn't work, kopete requires a specific development snapshot of libgadu.
	# Maybe we can enable it in the future.
	# The nowlistening plugin has xmms support.
	local myconf="$(use_enable sametime sametime-plugin)
		$(use_with xmms) --without-external-libgadu"

	kde-meta_src_compile
}
