# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/uget/uget-1.7.3.ebuild,v 1.5 2012/05/03 06:01:03 jdhore Exp $

EAPI="4"

inherit base

DESCRIPTION="Download manager using gtk+ and libcurl"
HOMEPAGE="http://urlget.sourceforge.net/"
SRC_URI="mirror://sourceforge/urlget/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="aria2 +curl gstreamer hide-temp-files libnotify nls"

REQUIRED_USE="|| ( aria2 curl )"

RDEPEND="
	dev-libs/libpcre
	>=dev-libs/glib-2:2
	>=x11-libs/gtk+-2.18:2
	curl? ( >=net-misc/curl-7.10 )
	gstreamer? ( media-libs/gstreamer )
	libnotify? ( x11-libs/libnotify )
	"
DEPEND="${RDEPEND}
	dev-util/intltool
	virtual/pkgconfig
	sys-devel/gettext"

pkg_setup() {
	echo
	ewarn "Be warned that the configuration file has been split into smaller"
	ewarn "files in Uget >= 1.5.9 and Uget will not attempt to import your"
	ewarn "old settings."
	ewarn
	ewarn "In other words, you will lose your current download lists."
	echo
}

src_configure() {
	econf $(use_enable nls) \
		  $(use_enable curl plugin-curl) \
		  $(use_enable aria2 plugin-aria2) \
		  $(use_enable gstreamer) \
		  $(use_enable hide-temp-files hidden) \
		  $(use_enable libnotify notify) || die "econf failed"
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	# the build system forgets this :p
	dobin uget-cmd/uget-cmd || die "uget-cmd install failed"

	dodoc AUTHORS ChangeLog NEWS README || die "dodoc failed"
}

pkg_postinst() {
	if use aria2; then
		echo
		elog "You've enabled the aria2 USE flag, so the aria2 plug-in has been"
		elog "built. This allows you to control a local or remote instance of aria2"
		elog "through xmlrpc. To use aria2 locally you have to emerge"
		elog "net-misc/aria2 with the xmlrpc USE enabled manually."
		echo
	fi
}
