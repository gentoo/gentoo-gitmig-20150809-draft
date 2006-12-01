# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kopete/kopete-3.5.2.ebuild,v 1.16 2006/12/01 20:16:11 flameeyes Exp $

KMNAME=kdenetwork
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE multi-protocol IM client"
HOMEPAGE="http://kopete.kde.org/"

KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="kdehiddenvisibility kernel_linux sametime ssl"

# The kernel_linux? ( ) conditional dependencies are for webcams, not supported
# on other kernels AFAIK
BOTH_DEPEND="dev-libs/libxslt
	dev-libs/libxml2
	net-dns/libidn
	>=dev-libs/glib-2
	app-crypt/qca
	sametime? ( =net-libs/meanwhile-0.4* )
	|| ( (
		x11-libs/libX11
		x11-libs/libXext
		x11-libs/libXrender
		x11-libs/libXScrnSaver
		) <virtual/x11-7 )
	kernel_linux? ( virtual/opengl )"

RDEPEND="${BOTH_DEPEND}
	ssl? ( app-crypt/qca-tls )"

DEPEND="${BOTH_DEPEND}
	kernel_linux? ( virtual/os-headers )
	|| ( (
			x11-proto/videoproto
			x11-proto/xproto
			kernel_linux? ( x11-libs/libXv )
			x11-proto/scrnsaverproto
		) <virtual/x11-7 )"

pkg_setup() {
	if use kernel_linux && ! built_with_use =x11-libs/qt-3* opengl; then
		eerror "To support Video4Linux webcams in this package is required to have"
		eerror "=x11-libs/qt-3* compiled with OpenGL support."
		eerror "Please reemerge =x11-libs/qt-3* with USE=\"opengl\"."
		die "Please reemerge =x11-libs/qt-3* with USE=\"opengl\"."
	fi
}

src_compile() {
	# External libgadu support - doesn't work, kopete requires a specific development snapshot of libgadu.
	# Maybe we can enable it in the future.
	local myconf="$(use_enable sametime sametime-plugin)
		--without-xmms --without-external-libgadu"

	kde-meta_src_compile
}

pkg_postinst() {
	elog "Since 11 July 2006 this version of Kopete cannot connect to ICQ service anymore."
	elog "You're currently invited to use either >=kde-base/kopete-3.5.3-r2 or"
	elog ">=net-im/kopete-0.12.0-r2	 that are patched to support the new authentication."
	elog "For more information, please look at the following bugs:"
	elog "	  http://bugs.kde.org/show_bug.cgi?id=130630"
	elog "	  http://bugs.gentoo.org/show_bug.cgi?id=140009"
}
