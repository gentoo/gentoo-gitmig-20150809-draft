# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/exaile/exaile-0.3.1.0.ebuild,v 1.1 2010/04/06 12:10:08 ssuominen Exp $

EAPI=2

PYTHON_DEPEND="2:2.6"
PYTHON_USE_WITH="sqlite"

inherit fdo-mime multilib python

DESCRIPTION="a media player aiming to be similar to AmaroK, but for GTK+"
HOMEPAGE="http://www.exaile.org/"
SRC_URI="http://launchpad.net/exaile/0.3.1/0.3.1/+download/${P}.tar.gz"

LICENSE="GPL-2 GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="cddb libnotify nls"

RDEPEND="dev-python/dbus-python
	>=media-libs/mutagen-1.10
	>=dev-python/pygtk-2.14
	>=dev-python/pygobject-2.18
	dev-python/gst-python:0.10
	media-libs/gst-plugins-good:0.10
	media-plugins/gst-plugins-meta:0.10
	libnotify? ( dev-python/notify-python )
	cddb? ( dev-python/cddb-py )"
DEPEND="nls? ( dev-util/intltool
	sys-devel/gettext )"

pkg_setup() {
	python_set_active_version 2
}

src_prepare() {
	sed -i \
		-e "s:exec python:exec $(PYTHON):" \
		exaile tools/generate-launcher || die
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
	doins -r data/migrations || die
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
