# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/webkit-gtk/webkit-gtk-0_p46193.ebuild,v 1.2 2009/07/24 15:09:14 mr_bones_ Exp $

EAPI=2

AT_M4DIR=./autotools
WX_GTK_VER="2.8"
inherit autotools flag-o-matic eutils wxwidgets

MY_P="WebKit-r${PV/0\_p}"
DESCRIPTION="Open source web browser engine"
HOMEPAGE="http://www.webkit.org/"
SRC_URI="http://nightly.webkit.org/files/trunk/src/${MY_P}.tar.bz2"

LICENSE="LGPL-2 LGPL-2.1 BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 -ia64 ~ppc -sparc ~x86 ~x86-fbsd"
IUSE="coverage debug gstreamer pango soup sqlite svg wxwidgets xslt"

RDEPEND=">=x11-libs/gtk+-2.8
	>=dev-libs/icu-3.8.1-r1
	>=net-misc/curl-7.15
	media-libs/jpeg
	media-libs/libpng
	dev-libs/libxml2
	sqlite? ( >=dev-db/sqlite-3 )
	gstreamer? (
		>=media-libs/gst-plugins-base-0.10
		)
	soup? ( >=net-libs/libsoup-2.27.4 )
	xslt? ( dev-libs/libxslt )
	pango? ( x11-libs/pango )
	wxwidgets? ( x11-libs/wxGTK )"

DEPEND="${RDEPEND}
	dev-util/gperf
	dev-util/pkgconfig
	virtual/perl-Text-Balanced"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	epatch "${FILESDIR}/${PN}-0_p46126-cxxmissing.patch"
	epatch "${FILESDIR}/${PN}-0_p46126-wxslot-gentoo.patch"
	epatch "${FILESDIR}/${PN}-0_p46126-wx-parallel-make.patch"
	epatch "${FILESDIR}/${PN}-0_p46193-bake.patch"
	gtkdocize
	eautoreconf
}

src_configure() {
	# It doesn't compile on alpha without this LDFLAGS
	use alpha && append-ldflags "-Wl,--no-relax"

	local myconf
	use pango && myconf="${myconf} --with-font-backend=pango"
	use soup && myconf="${myconf} --with-http-backend=soup"

	econf \
		$(use_enable sqlite database) \
		$(use_enable sqlite icon-database) \
		$(use_enable sqlite dom-storage) \
		$(use_enable sqlite offline-web-applications) \
		$(use_enable gstreamer video) \
		$(use_enable svg) \
		$(use_enable debug) \
		$(use_enable xslt) \
		$(use_enable coverage) \
		${myconf} \
		|| die "configure failed"
}

src_compile() {
	emake || die "emake failed"

	if use wxwidgets ; then
		# Upstream without further comment
		cd ${S}
		cp DerivedSources/JSDataGridC*.{cpp,h} WebCore/bindings/js || die "copy failed"

		cd ${S}/WebKitTools/wx
		./build-wxwebkit || die "wxwebkit build failed"
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die "Install failed"
}
