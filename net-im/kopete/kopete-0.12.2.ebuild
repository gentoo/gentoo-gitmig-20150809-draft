# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/kopete/kopete-0.12.2.ebuild,v 1.1 2006/08/31 10:07:15 flameeyes Exp $

inherit kde eutils

MY_P="${P/_/-}"
MY_P="${MY_P/.0/}"

DESCRIPTION="KDE multi-protocol IM client"
HOMEPAGE="http://kopete.kde.org/"
LICENSE="GPL-2"

KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="jingle sametime ssl xmms xscreensaver slp kernel_linux latex crypt
	  winpopup sms irc yahoo gadu groupwise netmeeting statistics autoreplace
	  connectionstatus contactnotes translator webpresence texteffect highlight
	  alias autoreplace history nowlistening addbookmarks kdehiddenvisibility"

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
		) <virtual/x11-7 )
	kernel_linux? ( virtual/opengl )
	sms? ( app-mobilephone/gsmlib )"

RDEPEND="${BOTH_DEPEND}
	ssl? ( app-crypt/qca-tls )
	!kde-base/kopete
	!kde-base/kdenetwork
	latex? ( virtual/tetex )
	crypt? ( app-crypt/gnupg )"
#	gnomemeeting is deprecated and ekiga is not yet ~ppc64
#	only needed for calling
#	netmeeting? ( net-im/gnomemeeting )"

DEPEND="${BOTH_DEPEND}
	kernel_linux? ( virtual/os-headers )
	|| ( (
			x11-proto/videoproto
			x11-proto/xextproto
			x11-proto/xproto
			kernel_linux? ( x11-libs/libXv )
			xscreensaver? ( x11-proto/scrnsaverproto )
		) <virtual/x11-7 )"

need-kde 3.4

#dev-libs/ilbc-rfc3951: could not see any benifit in it
#sed -i 's:ilbc_found="no":ilbc_found="yes":' ${S}/kopete/protocols/jabber/jingle/configure.in.in

pkg_setup() {
	if use kernel_linux && ! built_with_use =x11-libs/qt-3* opengl; then
		eerror "To support Video4Linux webcams in this package is required to have"
		eerror "=x11-libs/qt-3* compiled with OpenGL support."
		eerror "Please reemerge =x11-libs/qt-3* with USE=\"opengl\"."
		die "Please reemerge =x11-libs/qt-3* with USE=\"opengl\"."
	fi
}

kopete_disable() {
	einfo "Disabling $2 $1"
	sed -i -e "s/$2//" "${S}/kopete/$1s/Makefile.am"
}

src_unpack() {
	kde_src_unpack
	epatch "${FILESDIR}/${PN}-0.12_alpha1-xscreensaver.patch"
	# use ekiga instead of gnomemeeting by default
	epatch "${FILESDIR}/gnomemeeting-ekiga.patch"

	use latex || kopete_disable plugin latex
	use crypt || kopete_disable plugin cryptography
	use netmeeting || kopete_disable plugin netmeeting
	use statistics || kopete_disable plugin statistics
	use autoreplace || kopete_disable plugin autoreplace
	use connectionstatus || kopete_disable plugin connectionstatus
	use contactnotes || kopete_disable plugin contactnotes
	use translator || kopete_disable plugin translator
	use webpresence || kopete_disable plugin webpresence
	use texteffect || kopete_disable plugin texteffect
	use highlight || kopete_disable plugin highlight
	use alias || kopete_disable plugin alias
	use addbookmarks || kopete_disable plugin addbookmarks
	use history || kopete_disable plugin history
	use nowlistening || kopete_disable plugin nowlistening

	use winpopup || kopete_disable protocol winpopup
	use gadu || kopete_disable protocol '\$(GADU)'
	use irc || kopete_disable protocol irc
	use groupwise || kopete_disable protocol groupwise
	use yahoo || kopete_disable protocol yahoo

	rm -f "${S}/configure"
}

src_compile() {
	# External libgadu support - doesn't work, kopete requires a specific development snapshot of libgadu.
	# Maybe we can enable it in the future.
	# The nowlistening plugin has xmms support.
	local myconf="$(use_enable jingle)
		$(use_enable sametime sametime-plugin)
		$(use_with xmms) --without-external-libgadu
		$(use_with xscreensaver) $(use_enable sms smsgsm)
		$(use_enable debug testbed)"

	kde_src_compile
}

src_install() {
	kde_src_install

	rm -f "${D}"/usr/bin/{stun,relay}server
}
