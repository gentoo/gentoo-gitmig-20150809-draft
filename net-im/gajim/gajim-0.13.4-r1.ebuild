# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/gajim/gajim-0.13.4-r1.ebuild,v 1.3 2010/08/07 17:25:57 armin76 Exp $

EAPI="2"

PYTHON_DEPEND="2"
PYTHON_USE_WITH="sqlite xml"
inherit autotools eutils python versionator

DESCRIPTION="Jabber client written in PyGTK"
HOMEPAGE="http://www.gajim.org/"
SRC_URI="http://www.gajim.org/downloads/$(get_version_component_range 1-2)/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="avahi crypt dbus gnome idle libnotify nls spell srv trayicon X xhtml"

COMMON_DEPEND=">=dev-python/pygtk-2.12.0"

DEPEND="${COMMON_DEPEND}
	>=sys-devel/gettext-0.17-r1
	>=dev-util/intltool-0.40.1
	dev-util/pkgconfig"

RDEPEND="${COMMON_DEPEND}
	dev-python/pyopenssl
	dev-python/sexy-python
	crypt? (
		app-crypt/gnupg
		dev-python/pycrypto
		)
	dbus? (
		dev-python/dbus-python
		dev-libs/dbus-glib
		libnotify? ( dev-python/notify-python )
		avahi? ( net-dns/avahi[dbus,gtk,python] )
		)
	gnome? (
		dev-python/libgnome-python
		dev-python/gnome-keyring-python
		trayicon? ( dev-python/egg-python )
		)
	idle? ( x11-libs/libXScrnSaver )
	srv? (
		|| (
			dev-python/libasyncns-python
			net-dns/bind-tools )
		)
	spell? ( app-text/gtkspell )
	xhtml? ( dev-python/docutils )"

pkg_setup() {
	if ! use dbus; then
		if use libnotify; then
			eerror "The dbus USE flag is required for libnotify support"
			die "USE=\"dbus\" needed for libnotify support"
		fi
		if use avahi; then
			eerror "The dbus USE flag is required for avahi support"
			die "USE=\"dbus\" needed for avahi support"
		fi
	fi
	python_set_active_version 2
}

src_prepare() {
	# install pyfiles in /usr/lib/python2.x/site-packages/gajim
	# upstream: http://trac.gajim.org/ticket/5460
	# Should be in 0.14
	epatch "${FILESDIR}/${PN}-0.13-autotools-enable-site-packages_option.patch"
	epatch "${FILESDIR}"/${PV}-python-version.patch
	eautoreconf
	echo '#!/bin/sh' > config/py-compile
}

src_configure() {
	local myconf

	if ! use gnome; then
		myconf+=" $(use_enable trayicon)"
	fi

	econf \
		$(use_enable nls) \
		$(use_with X x) \
		--docdir="/usr/share/doc/${PF}" \
		--libdir="$(python_get_sitedir)" \
		--enable-site-packages \
		${myconf}
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	rm "${D}/usr/share/doc/${PF}/"{README.html,COPYING} || die
	dohtml README.html || die
}

pkg_postinst() {
	python_mod_optimize $(python_get_sitedir)/${PN}
}

pkg_postrm() {
	python_mod_cleanup $(python_get_sitedir)/${PN}
}
