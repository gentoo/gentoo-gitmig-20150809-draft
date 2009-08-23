# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/exaile/exaile-0.3.0_alpha3.ebuild,v 1.4 2009/08/23 14:11:35 ssuominen Exp $

EAPI=2
inherit eutils fdo-mime multilib python

MY_P=${P/_alpha/a}

DESCRIPTION="a media player aiming to be similar to AmaroK, but for GTK+"
HOMEPAGE="http://www.exaile.org"
SRC_URI="http://www.exaile.org/files/${MY_P}.tar.gz"

LICENSE="GPL-2 GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="cddb doc hal libnotify +libsexy nls"

RDEPEND="dev-python/dbus-python
	>=media-libs/mutagen-1.10
	>=dev-python/pygtk-2.12
	>=dev-lang/python-2.5[sqlite]
	dev-python/gst-python:0.10
	media-libs/gst-plugins-good:0.10
	media-plugins/gst-plugins-meta:0.10
	libnotify? ( dev-python/notify-python )
	libsexy? ( dev-python/sexy-python )
	hal? ( sys-apps/hal )
	cddb? ( dev-python/cddb-py )"
DEPEND="doc? ( dev-python/sphinx )
	nls? ( dev-util/intltool
		sys-devel/gettext )"

S=${WORKDIR}/${PN}

src_prepare() {
	epatch "${FILESDIR}"/${P}-Makefile.patch
}

src_compile() {
	if use nls; then
		emake translations || die "emake translations failed"
	fi
	if use doc; then
		cd doc
		emake html || die "emake html failed"
	fi
}

src_install() {
	local _no_locale

	use nls || _no_locale=_no_locale

	emake PREFIX="/usr" LIBINSTALLDIR="/$(get_libdir)" DESTDIR="${D}" \
		install${_no_locale} || die "emake install failed"

	dodoc crossfade_design FUTURE PLANNING player_planning \
		README SEARCHING || die "dodoc failed"

	if use doc; then
		dohtml -r doc/_build/html/* || die "dohtml failed"
	fi
}

pkg_postinst() {
	python_need_rebuild
	python_mod_optimize /usr/$(get_libdir)/${PN}
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
}

pkg_postrm() {
	python_mod_cleanup /usr/$(get_libdir)/${PN}
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
}
