# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dns/avahi/avahi-0.1.ebuild,v 1.7 2005/08/23 00:10:24 swegener Exp $

inherit eutils linux-info

DESCRIPTION="System which facilitates service discovery on a local network"
HOMEPAGE="http://www.freedesktop.org/Software/Avahi"
SRC_URI="http://bur.st/~lathiat/${PN}/${P}.tar.gz"

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
	python? (
		>=virtual/python-2.4
		>=dev-python/pygtk-2
	)
	dbus? ( >=sys-apps/dbus-0.30 )"
DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )"

pkg_setup() {
	linux-info_pkg_setup

	enewgroup avahi
	enewuser avahi -1 -1 -1 avahi

	if ! linux_chkconfig_present IP_MULTICAST
	then
		ewarn
		ewarn "Your kernel doesn't seem to have IP_MULTICAST enabled,"
		ewarn "which is needed for avahi to work correctly."
		ewarn
		ewarn "Continuing..."
		ewarn
		epause
	fi
}

src_compile() {
	econf \
		--localstatedir=/var \
		--with-distro=gentoo \
		--disable-xmltoman \
		$(use_enable doc doxygen-doc) \
		$(use_enable python) \
		$(use_enable dbus) \
		$(use_enable gtk) \
		$(use_enable gtk glib) \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make install DESTDIR="${D}" || die "make install failed"

	# Try to remove this directory, it exists if we don't have python support
	rmdir "${D}"/avahi &>/dev/null

	newinitd "${FILESDIR}"/avahi.initd avahi
	newinitd "${FILESDIR}"/avahi-dnsconfd.initd avahi-dnsconfd
	dodoc docs/{AUTHORS,README,TODO}
}
