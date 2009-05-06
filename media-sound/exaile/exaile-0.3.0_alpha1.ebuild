# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/exaile/exaile-0.3.0_alpha1.ebuild,v 1.1 2009/05/06 17:28:19 ssuominen Exp $

EAPI=2
inherit eutils fdo-mime multilib python

MY_PV=${PV/_alpha/a}

DESCRIPTION="a media player aiming to be similar to AmaroK, but for GTK+"
HOMEPAGE="http://www.exaile.org"
SRC_URI="http://www.exaile.org/files/${PN}_${MY_PV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="cddb doc hal libnotify +libsexy nls"

RDEPEND="dev-python/dbus-python
	>=media-libs/mutagen-1.10
	>=dev-python/pygtk-2.10
	>=dev-lang/python-2.5[sqlite]
	dev-python/gst-python:0.10
	media-libs/gst-plugins-good:0.10
	media-plugins/gst-plugins-meta:0.10
	libnotify? ( dev-python/notify-python )
	libsexy? ( dev-python/sexy-python )
	hal? ( sys-apps/hal )
	cddb? ( dev-python/cddb-py )"
DEPEND="doc? ( dev-python/epydoc )
	nls? ( dev-util/intltool
	sys-devel/gettext )"

S=${WORKDIR}/${PN}-${MY_PV}

src_prepare() {
	epatch "${FILESDIR}"/${P}-bytecompile.patch
}

src_compile() {
	if use nls; then
		emake translations || die "emake translations failed"
	fi

	if use doc; then
		emake doc || die "emake doc failed"
	fi
}

src_install() {
	emake -j1 PREFIX="/usr" LIBDIR="/$(get_libdir)" \
		DESTDIR="${D}" install || die "emake install failed"

	dodoc crossfade_design FUTURE PLANNING player_planning \
		README SEARCHING
}

pkg_postinst() {
	python_mod_optimize /usr/$(get_libdir)/${PN}
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
}

pkg_postrm() {
	python_mod_cleanup /usr/$(get_libdir)/${PN}
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
}
