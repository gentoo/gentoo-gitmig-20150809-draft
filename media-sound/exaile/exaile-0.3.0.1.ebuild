# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/exaile/exaile-0.3.0.1.ebuild,v 1.1 2009/10/20 14:47:17 ssuominen Exp $

EAPI=2
inherit eutils fdo-mime multilib python

DESCRIPTION="a media player aiming to be similar to AmaroK, but for GTK+"
HOMEPAGE="http://www.exaile.org/"
SRC_URI="http://launchpad.net/exaile/0.3.0/${PV}/+download/${P}.tar.gz"

LICENSE="GPL-2 GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="cddb hal libnotify +libsexy nls"

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
DEPEND="nls? ( dev-util/intltool
	sys-devel/gettext )"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-0.3.0-Makefile.patch \
		"${FILESDIR}"/${PN}-0.3.0-Makefile-2.patch
}

src_compile() {
	if use nls; then
		emake locale || die
	fi
}

src_install() {
	local _no_locale
	use nls || _no_locale=_no_locale

	emake PREFIX="/usr" LIBINSTALLDIR="/$(get_libdir)" DESTDIR="${D}" \
		install${_no_locale} || die

	dodoc README

	insinto /usr/share/exaile/data
	doins -r data/migrations || die "doins failed"
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
