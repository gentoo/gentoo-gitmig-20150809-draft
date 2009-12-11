# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-auth/polkit/polkit-0.95.ebuild,v 1.2 2009/12/11 17:25:46 nirbheek Exp $

EAPI="2"

inherit autotools eutils multilib pam

DESCRIPTION="Policy framework for controlling privileges for system-wide services"
HOMEPAGE="http://hal.freedesktop.org/docs/PolicyKit"
SRC_URI="http://hal.freedesktop.org/releases/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug doc examples expat nls"
# building w/o pam is broken, bug 291116
# introspection pam

# not mature enough
#	introspection? ( dev-libs/gobject-introspection )
RDEPEND=">=dev-libs/glib-2.21.4
	>=dev-libs/eggdbus-0.6
	virtual/pam
	expat? ( dev-libs/expat )"
DEPEND="${RDEPEND}
	!!>=sys-auth/policykit-0.92
	dev-libs/libxslt
	app-text/docbook-xsl-stylesheets
	>=dev-util/pkgconfig-0.18
	>=dev-util/intltool-0.36
	dev-util/gtk-doc-am
	doc? ( >=dev-util/gtk-doc-1.10 )"
PDEPEND=">=sys-auth/consolekit-0.4[policykit]"

pkg_setup() {
	enewgroup polkituser
	enewuser polkituser -1 "-1" /dev/null polkituser
}

src_prepare() {
	# Fix daemon binary collision with <=policykit-0.9, fdo bug 22951
	epatch "${FILESDIR}/${PN}-0.93-fix-daemon-name.patch"

	intltoolize --force --copy --automake || die "intltoolize failed"
	eautoreconf
}

src_configure() {
	local conf

	if use expat; then
		conf="${conf} --with-expat=/usr"
	fi

	econf ${conf} \
		--disable-introspection \
		--disable-ansi \
		--disable-examples \
		--enable-fast-install \
		--enable-libtool-lock \
		--enable-man-pages \
		--disable-dependency-tracking \
		--with-os-type=gentoo \
		--localstatedir=/var \
		--with-authfw=pam \
		--with-pam-module-dir=$(getpam_mod_dir) \
		$(use_enable debug verbose-mode) \
		$(use_enable doc gtk-doc) \
		$(use_enable nls)
		#$(use_enable introspection)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	dodoc NEWS README AUTHORS ChangeLog || die "dodoc failed"

	# We disable example compilation above, and handle it here
	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins src/examples/{*.c,*.policy*}
	fi

	# Need to keep a few directories around...
	diropts -m0700 -o root -g polkituser
	keepdir /var/run/polkit-1
	keepdir /var/lib/polkit-1
}
