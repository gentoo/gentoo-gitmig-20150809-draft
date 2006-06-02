# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/kopete/kopete-0.12.0.ebuild,v 1.3 2006/06/02 20:03:48 genstef Exp $

inherit kde eutils

MY_P="${P/_/-}"
MY_P="${MY_P/.0/}"

DESCRIPTION="KDE multi-protocol IM client"
HOMEPAGE="http://kopete.kde.org/"
LICENSE="GPL-2"

KEYWORDS="~amd64 ~ppc ~x86"
IUSE="jingle sametime ssl xmms xscreensaver kdehiddenvisibility"

SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.bz2"

# The kernel_linux? ( ) conditional dependencies are for webcams, not supported
# on other kernels AFAIK
BOTH_DEPEND="dev-libs/libxslt
	dev-libs/libxml2
	net-dns/libidn
	>=dev-libs/glib-2
	app-crypt/qca
	slp? ( net-libs/openslp )
	jingle? (
		>=media-libs/speex-1.1.6
		dev-libs/expat
		~net-libs/ortp-0.7.1 )
	sametime? ( =net-libs/meanwhile-0.4* )
	xmms? ( media-sound/xmms )
	|| ( (
		x11-libs/libX11
		x11-libs/libXext
		x11-libs/libXrender
		xscreensaver? ( x11-libs/libXScrnSaver )
		) virtual/x11 )
	kernel_linux? ( virtual/opengl )"

RDEPEND="${BOTH_DEPEND}
	ssl? ( app-crypt/qca-tls )
	!kde-base/kopete
	!kde-base/kdenetwork
	!net-libs/libjingle"

DEPEND="${BOTH_DEPEND}
	kernel_linux? ( virtual/os-headers )
	|| ( (
			x11-proto/videoproto
			x11-proto/xextproto
			x11-proto/xproto
			kernel_linux? ( x11-libs/libXv )
			xscreensaver? ( x11-proto/scrnsaverproto )
		) virtual/x11 )"

need-kde 3.4

#dev-libs/ilbc-rfc3951: could not see any benifit in it
#sed -i 's:ilbc_found="no":ilbc_found="yes":' ${S}/kopete/protocols/jabber/jingle/configure.in.in

src_unpack() {
	kde_src_unpack
	epatch "${FILESDIR}/${PN}-0.12_alpha1-xscreensaver.patch"
	rm -f ${S}/configure
}

src_compile() {
	# External libgadu support - doesn't work, kopete requires a specific development snapshot of libgadu.
	# Maybe we can enable it in the future.
	# The nowlistening plugin has xmms support.
	local myconf="$(use_enable jingle)
		$(use_enable sametime sametime-plugin)
		$(use_with xmms) --without-external-libgadu
		$(use_with xscreensaver)"

	kde_src_compile
}
