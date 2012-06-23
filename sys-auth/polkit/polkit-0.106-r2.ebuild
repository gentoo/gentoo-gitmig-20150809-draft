# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-auth/polkit/polkit-0.106-r2.ebuild,v 1.4 2012/06/23 04:01:20 ssuominen Exp $

EAPI=4
inherit eutils pam systemd user

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
	pam? (
		sys-auth/pambase
		virtual/pam
		)
	systemd? ( sys-apps/systemd )"
DEPEND="${RDEPEND}
	app-text/docbook-xml-dtd:4.1.2
	app-text/docbook-xsl-stylesheets
	dev-libs/libxslt
	dev-util/intltool
	virtual/pkgconfig"
PDEPEND="
	gtk? ( || (
		>=gnome-extra/polkit-gnome-0.105
		lxde-base/lxpolkit
		) )
	kde? ( sys-auth/polkit-kde-agent )
	pam? (
		systemd? ( sys-auth/pambase[systemd] )
		!systemd? ( sys-auth/pambase[consolekit] )
		)
	!systemd? ( >=sys-auth/consolekit-0.4.5_p2012[policykit] )"

DOCS="docs/TODO HACKING NEWS README"

pkg_setup() {
	local u=polkitd
	local g=polkitd
	local h=/var/lib/polkit-1

	enewgroup ${g}
	enewuser ${u} -1 -1 ${h} ${g}
	esethome ${u} ${h}
}

src_prepare() {
	sed -i -e '/unix-group/s:wheel:adm:' src/polkitbackend/*-default.rules || die #401513

	has_version ">=dev-lang/spidermonkey-1.8.7" && { sed -i -e '/mozjs/s:185:187:g' configure || die; }
}

src_configure() {
	local myconf="--with-authfw=shadow"
	use pam && \
		myconf="--with-authfw=pam --with-pam-module-dir=$(getpam_mod_dir) --with-pam-include=system-local-login"

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
		"$(systemd_with_unitdir)" \
		${myconf}
}

src_install() {
	default

	fowners -R polkitd:root /{etc,usr/share}/polkit-1/rules.d

	prune_libtool_files

	diropts -m0700 -o polkitd -g polkitd
	keepdir /var/lib/polkit-1

	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins src/examples/{*.c,*.policy*}
	fi
}

pkg_postinst() {
	chown -R polkitd:root "${EROOT}"/{etc,usr/share}/polkit-1/rules.d
	chown -R polkitd:polkitd "${EROOT}"/var/lib/polkit-1

	echo
	ewarn "The default administrator unix-group was changed from \"wheel\" to"
	ewarn "\"adm\", see *-default.rules in /etc/polkit-1/rules.d"
	ewarn "Users of unix-group \"adm\" can run, for example, \"pkexec /bin/sh\""
	ewarn "to gain root shell without root password."
	ewarn "For more information, see http://bugs.gentoo.org/401513"
}
