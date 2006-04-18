# Copyright 2000-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dns/avahi/avahi-0.6.9.ebuild,v 1.5 2006/04/18 20:01:41 swegener Exp $

inherit eutils qt3 mono python

DESCRIPTION="System which facilitates service discovery on a local network"
HOMEPAGE="http://avahi.org/"
SRC_URI="http://avahi.org/download/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~sh sparc ~x86"
IUSE="bookmarks howl-compat mdnsresponder-compat gdbm dbus doc mono gtk python qt"

# We have USE flags depending on each other, which leads to this logic. We
# prefer an activated USE flag and override the dependent USE flags.

RDEPEND=">=dev-libs/libdaemon-0.5
	dev-libs/expat
	>=dev-libs/glib-2
	gdbm? ( sys-libs/gdbm )
	qt? ( $(qt_min_version 3.3) )
	gtk? (
		>=x11-libs/gtk+-2
		>=gnome-base/libglade-2
	)
	mono? (
		>=dev-lang/mono-1.1.10
		>=sys-apps/dbus-0.30
	)
	dbus? (
		>=sys-apps/dbus-0.30
		howl-compat? ( !net-misc/howl )
		mdnsresponder-compat? ( !net-misc/mDNSResponder )
	)
	python? (
		>=virtual/python-2.4
		gtk? ( >=dev-python/pygtk-2 )
	)
	bookmarks? (
		>=virtual/python-2.4
		>=sys-apps/dbus-0.30
		dev-python/twisted
		dev-python/twisted-web
	)
	"
DEPEND="${RDEPEND}
	doc? (
		app-doc/doxygen
		mono? ( >=dev-util/monodoc-1.1.8 )
	)"

export PKG_CONFIG_PATH="${QTDIR}/lib/pkgconfig"

pkg_setup() {
	if use python && ! built_with_use dev-lang/python gdbm ; then
		die "Need dev-lang/python compiled with gdbm support!"
	fi
}

pkg_preinst() {
	enewgroup avahi
	enewuser avahi -1 -1 -1 avahi
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${PN}-0.6.1-no-ipv6.patch
}

src_compile() {
	local myconf=""

	if use python
	then
		use dbus && myconf="${myconf} --enable-python-dbus"
		use gtk && myconf="${myconf} --enable-pygtk"
	fi

	if use mono
	then
		myconf="${myconf} --enable-dbus"

		use doc && myconf="${myconf} --enable-monodoc"
	fi

	if use bookmarks
	then
		myconf="${myconf} --enable-python --enable-dbus --enable-python-dbus"
	fi

	econf \
		--localstatedir=/var \
		--with-distro=gentoo \
		--disable-qt4 \
		--disable-python-dbus \
		--disable-pygtk \
		--disable-xmltoman \
		--disable-monodoc \
		--enable-glib \
		$(use_enable mdnsresponder-compat compat-libdns_sd) \
		$(use_enable howl-compat compat-howl) \
		$(use_enable doc doxygen-doc) \
		$(use_enable mono) \
		$(use_enable dbus) \
		$(use_enable python) \
		$(use_enable gtk) \
		$(use_enable qt qt3) \
		$(use_enable gdbm) \
		${myconf} \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make install DESTDIR="${D}" || die "make install failed"
	use bookmarks || rm -f "${D}"/usr/bin/avahi-bookmarks

	dodoc docs/{AUTHORS,README,TODO}
}

pkg_postrm() {
	python_mod_cleanup "${ROOT}"/usr/lib/python*/site-packages/avahi
}

pkg_postinst() {
	python_mod_optimize "${ROOT}"/usr/lib/python*/site-packages/avahi
}
