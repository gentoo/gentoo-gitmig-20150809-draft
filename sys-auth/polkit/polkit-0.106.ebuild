# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-auth/polkit/polkit-0.106.ebuild,v 1.4 2012/06/13 15:28:32 ssuominen Exp $

EAPI=4
inherit eutils user pam systemd

DESCRIPTION="Policy framework for controlling privileges for system-wide services"
HOMEPAGE="http://www.freedesktop.org/wiki/Software/polkit"
SRC_URI="http://www.freedesktop.org/software/${PN}/releases/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="debug examples gtk +introspection kde nls pam systemd"

RDEPEND=">=dev-lang/spidermonkey-1.8.5
	>=dev-libs/glib-2.32
	>=dev-libs/expat-2
	introspection? ( >=dev-libs/gobject-introspection-1 )
	pam? ( virtual/pam )
	systemd? ( sys-apps/systemd )"
DEPEND="${RDEPEND}
	app-text/docbook-xml-dtd:4.1.2
	app-text/docbook-xsl-stylesheets
	dev-libs/libxslt
	>=dev-util/intltool-0.40
	virtual/pkgconfig"
PDEPEND="
	gtk? ( || (
		>=gnome-extra/polkit-gnome-0.104-r1
		lxde-base/lxpolkit
		) )
	kde? ( || (
		sys-auth/polkit-kde-agent
		sys-auth/polkit-kde
		) )
	!systemd? (
		>=sys-auth/consolekit-0.4.5_p2012[policykit]
		pam? ( sys-auth/pambase[consolekit] )
		)"

DOCS="docs/TODO HACKING NEWS README"

pkg_setup() {
	enewgroup polkitd
	enewuser polkitd -1 -1 /var/lib/polkit-1 polkitd
}

src_prepare() {
	# http://bugs.gentoo.org/401513
	ewarn "Switching from group \"wheel\" to group \"0\" in	/etc/polkit-1/rules.d/*-default.rules"
	sed -i -e '/unix-group/s:wheel:0:' src/polkitbackend/*-default.rules || die
}

src_configure() {
	econf \
		--localstatedir="${EPREFIX}"/var \
		--disable-static \
		$(use_enable debug verbose-mode) \
		--enable-man-pages \
		--disable-gtk-doc \
		$(use_enable systemd libsystemd-login) \
		$(use_enable introspection) \
		--disable-examples \
		$(use_enable nls) \
		--with-os-type=gentoo \
		--with-authfw=$(usex pam pam shadow) \
		$(use pam && echo --with-pam-module-dir="$(getpam_mod_dir)") \
		"$(systemd_with_unitdir)"
}

src_install() {
	default

	prune_libtool_files

	diropts -m0700 -o polkitd -g polkitd
	keepdir /var/lib/polkit-1

	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins src/examples/{*.c,*.policy*}
	fi
}

pkg_postinst() {
	# fowners in src_install fails and Portage sets these back to root:root
	chown -R polkitd:polkitd "${EROOT}"/{etc,usr/share}/polkit-1/rules.d
	# enewuser fails to refresh itself for new home directory #420269
	sed -i -e '/^polkitd/s:/dev/null:/var/lib/polkit-1:' "${EROOT}"/etc/passwd
}
