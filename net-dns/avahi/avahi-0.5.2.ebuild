# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dns/avahi/avahi-0.5.2.ebuild,v 1.2 2005/11/04 07:23:58 swegener Exp $

inherit eutils qt3 mono

DESCRIPTION="System which facilitates service discovery on a local network"
HOMEPAGE="http://www.freedesktop.org/Software/Avahi"
SRC_URI="http://www.freedesktop.org/~lennart/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="dbus doc mono gtk python qt"

RDEPEND="dev-libs/libdaemon
	dev-libs/expat
	qt? ( $(qt_min_version 3.3) )
	gtk? (
		>=x11-libs/gtk+-2
		>=gnome-base/libglade-2
		>=dev-libs/glib-2
	)
	mono? ( >=dev-lang/mono-1.1.3 )
	dbus? (
		>=sys-apps/dbus-0.30
		python? (
			>=virtual/python-2.4
			>=dev-python/pygtk-2
		)
	)"
DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )"

# Future things:
# doc? ( mono? ( >=dev-util/monodoc-1.18 ) )

export PKG_CONFIG_PATH="${QTDIR}/lib/pkgconfig"

pkg_setup() {
	if ! built_with_use dev-lang/python gdbm
	then
		die "Need dev-lang/python compiled with gdbm support!"
	fi

	enewgroup avahi
	enewuser avahi -1 -1 -1 avahi
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
		--disable-python \
		--disable-qt4 \
		--disable-xmltoman \
		--disable-mono-docs \
		$(use_enable doc doxygen-doc) \
		$(use_enable mono) \
		$(use_enable dbus) \
		$(use_enable gtk) \
		$(use_enable qt qt3) \
		$(use_enable gtk glib) \
		${myconf} \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make install DESTDIR="${D}" || die "make install failed"

	dodoc docs/{AUTHORS,README,TODO}
}
