# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dns/avahi/avahi-0.2.ebuild,v 1.3 2005/08/29 01:52:25 swegener Exp $

inherit eutils

DESCRIPTION="System which facilitates service discovery on a local network"
HOMEPAGE="http://www.freedesktop.org/Software/Avahi"
SRC_URI="http://www.freedesktop.org/~lennart/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86"
IUSE="dbus doc gtk python"

RDEPEND="dev-libs/libdaemon
	dev-libs/expat
	gtk? (
		>=x11-libs/gtk+-2
		>=gnome-base/libglade-2
		>=dev-libs/glib-2
	)
	dbus? (
		>=sys-apps/dbus-0.30
		python? (
			>=virtual/python-2.4
			>=dev-python/pygtk-2
		)
	)"
DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )"

pkg_setup() {
	enewgroup avahi
	enewuser avahi -1 -1 -1 avahi
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${PV}-anydbm.patch
}

src_compile() {
	local myconf=""

	if use python && use dbus
	then
		myconf="${myconf} --enable-python"
	fi

	econf \
		--localstatedir=/var \
		--with-distro=gentoo \
		--disable-xmltoman \
		--disable-python \
		$(use_enable doc doxygen-doc) \
		$(use_enable dbus) \
		$(use_enable gtk) \
		$(use_enable gtk glib) \
		${myconf} \
		|| die "econf failed"
	emake -j1 || die "emake failed"
}

src_install() {
	make install DESTDIR="${D}" || die "make install failed"

	dodoc docs/{AUTHORS,README,TODO}
}
