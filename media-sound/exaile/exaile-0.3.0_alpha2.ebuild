# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/exaile/exaile-0.3.0_alpha2.ebuild,v 1.3 2009/06/07 06:42:25 ssuominen Exp $

EAPI=2
inherit eutils fdo-mime multilib python

MY_PV=${PV/_alpha/a}

DESCRIPTION="a media player aiming to be similar to AmaroK, but for GTK+"
HOMEPAGE="http://www.exaile.org"
SRC_URI="http://www.exaile.org/files/${PN}_${MY_PV}.tar.gz"

LICENSE="|| ( GPL-2 GPL-3 )"
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

S=${WORKDIR}/${PN}_${MY_PV}

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
	elog "This version is more or less a rewrite from 0.2.x series, so"
	elog "don't expect all the features you had before to be there yet."
	elog "It would be a good idea to remove your old exaile configs"
	elog "and databases out of the way before switching from 0.2.x."
	elog "These files are in your home directory in .exaile, .config/exaile"
	elog "and .local/share/exaile"
}

pkg_postrm() {
	python_mod_cleanup /usr/$(get_libdir)/${PN}
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
}
