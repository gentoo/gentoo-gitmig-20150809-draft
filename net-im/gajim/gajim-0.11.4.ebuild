# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/gajim/gajim-0.11.4.ebuild,v 1.8 2009/07/21 11:34:22 ssuominen Exp $

EAPI=2
inherit multilib python eutils

DESCRIPTION="Jabber client written in PyGTK"
HOMEPAGE="http://www.gajim.org/"
SRC_URI="http://www.gajim.org/downloads/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ~hppa ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="avahi dbus gnome idle libnotify nls spell srv trayicon X xhtml"

DEPEND=">=dev-lang/python-2.5[sqlite,xml]
	dev-python/pygtk
	sys-devel/gettext
	dev-util/intltool
	dev-util/pkgconfig"

RDEPEND="gnome? ( dev-python/gnome-python-extras
		dev-python/gnome-python-desktop
	)
	dbus? ( dev-python/dbus-python dev-libs/dbus-glib )
	libnotify? ( x11-libs/libnotify )
	xhtml? ( dev-python/docutils )
	srv? ( net-dns/bind-tools )
	idle? ( x11-libs/libXScrnSaver )
	spell? ( app-text/gtkspell )
	avahi? ( net-dns/avahi[dbus,gtk,python] )
	dev-python/pyopenssl"

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
	else
		if has_version "<sys-apps/dbus-0.90" && ! built_with_use sys-apps/dbus python; then
				eerror "Please rebuild dbus with USE=\"python\""
				die "USE=\"python\" needed for dbus"
		fi
	fi
}

src_prepare() {
	epatch "${FILESDIR}/${P}-test_fix.patch"
}

src_configure() {
	local myconf

	if ! use gnome; then
		myconf="${myconf} $(use_enable trayicon)"
		myconf="${myconf} $(use_enable idle)"
	fi

	econf $(use_enable nls) \
		$(use_enable spell gtkspell) \
		$(use_enable dbus remote) \
		$(use_with X x) \
		--docdir="/usr/share/doc/${PF}" \
		--prefix="/usr" \
		--libdir="/usr/$(get_libdir)" \
		${myconf}
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	rm "${D}/usr/share/doc/${PF}/README.html"
	dohtml README.html
}

pkg_postinst() {
	python_mod_optimize /usr/share/gajim/
}

pkg_postrm() {
	python_mod_cleanup /usr/share/gajim/
}
