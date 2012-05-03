# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/uget/uget-9999.ebuild,v 1.6 2012/05/03 06:01:03 jdhore Exp $

EAPI="4"

inherit autotools git-2

DESCRIPTION="Download manager using gtk+ and libcurl"
HOMEPAGE="http://urlget.sourceforge.net/"
SRC_URI=""

EGIT_REPO_URI="git://urlget.git.sourceforge.net/gitroot/urlget/uget"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS=""
IUSE="aria2 +curl gstreamer gtk3 hide-temp-files libnotify nls"

REQUIRED_USE="|| ( aria2 curl )"

RDEPEND="
	dev-libs/libpcre
	>=dev-libs/glib-2:2
	!gtk3? (
		>=x11-libs/gtk+-2.18:2
	)
	gtk3? (
		x11-libs/gtk+:3
	)
	curl? ( >=net-misc/curl-7.10 )
	gstreamer? ( media-libs/gstreamer )
	libnotify? ( x11-libs/libnotify )
	"
DEPEND="${RDEPEND}
	dev-util/intltool
	virtual/pkgconfig
	sys-devel/gettext"

src_prepare() {
	# add missing file, fix tests, bug #376203
	echo "uglib/UgPlugin-aria2.c" >> po/POTFILES.in ||
		die "echo in po/POTFILES.in failed"

	eautoreconf
	intltoolize || die "intltoolize failed"
	eautoreconf
}

src_configure() {
	econf $(use_enable nls) \
		  $(use_with gtk3) \
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

	dodoc AUTHORS ChangeLog README || die "dodoc failed"
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
