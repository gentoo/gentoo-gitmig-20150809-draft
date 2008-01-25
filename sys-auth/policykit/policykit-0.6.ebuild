# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-auth/policykit/policykit-0.6.ebuild,v 1.4 2008/01/25 10:30:09 armin76 Exp $

inherit eutils autotools multilib

MY_PN="PolicyKit"

DESCRIPTION="Policy framework for setting user allowed actions with priviledge"
HOMEPAGE="http://hal.freedesktop.org/docs/PolicyKit"
SRC_URI="http://hal.freedesktop.org/releases/${MY_PN}-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha ~amd64 ~hppa ia64 sparc ~x86"
IUSE="doc selinux"

RDEPEND=">=dev-libs/glib-2.7
		 >=dev-libs/dbus-glib-0.61
		 virtual/pam
		 dev-libs/expat
		 selinux? ( sys-libs/libselinux )"
DEPEND="${RDEPEND}
		dev-libs/libxslt
		dev-util/pkgconfig
		app-text/docbook-xsl-stylesheets
		doc? ( dev-util/gtk-doc )"

S="${WORKDIR}/${MY_PN}-${PV}"

pkg_setup() {
	enewgroup polkituser || die "failed to create group"
	enewuser polkituser -1 "-1" /dev/null polkituser || die "failed to create user"
}

src_compile() {
	econf --with-expat \
	--with-pam-module-dir=/$(get_libdir)/security \
	--with-os-type=gentoo \
	$(use_enable doc gtk-doc) \
	$(use_enable selinux) \
	--with-polkit-user=polkituser \
	--with-polkit-group=polkituser \
	--localstatedir=/var \
	|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	# Need to keep a few directories around...
	keepdir /var/run/PolicyKit
	keepdir /var/lib/PolicyKit
}
