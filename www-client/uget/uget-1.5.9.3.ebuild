# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/uget/uget-1.5.9.3.ebuild,v 1.1 2010/07/26 12:34:47 wired Exp $

EAPI="2"

inherit autotools base

DESCRIPTION="Download manager using gtk+ and libcurl"
HOMEPAGE="http://urlget.sourceforge.net/"
SRC_URI="mirror://sourceforge/urlget/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="gstreamer libnotify nls"

RDEPEND="
	dev-libs/libpcre
	>=dev-libs/glib-2
	>=net-misc/curl-7.10
	>=x11-libs/gtk+-2.18
	gstreamer? ( media-libs/gstreamer )
	libnotify? ( x11-libs/libnotify )
	"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	sys-devel/gettext"

src_prepare() {
	epatch "${FILESDIR}"/"${PN}"-1.5.9.2-as-needed.patch
	eautoreconf
}

src_configure() {
	econf $(use_enable nls) \
		  $(use_enable gstreamer) \
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
