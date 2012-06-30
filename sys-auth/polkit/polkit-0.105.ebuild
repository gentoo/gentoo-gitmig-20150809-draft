# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-auth/polkit/polkit-0.105.ebuild,v 1.3 2012/06/30 10:27:11 swift Exp $

EAPI=4
inherit pam

DESCRIPTION="Policy framework for controlling privileges for system-wide services"
HOMEPAGE="http://www.freedesktop.org/wiki/Software/polkit"
SRC_URI="http://www.freedesktop.org/software/${PN}/releases/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="debug doc examples gtk +introspection kde nls pam selinux systemd"

RDEPEND=">=dev-libs/glib-2.30
	>=dev-libs/expat-2
	introspection? ( >=dev-libs/gobject-introspection-0.6.2 )
	pam? ( virtual/pam )
	selinux? ( sec-policy/selinux-policykit )
	systemd? ( sys-apps/systemd )"
DEPEND="${RDEPEND}
	app-text/docbook-xml-dtd:4.1.2
	app-text/docbook-xsl-stylesheets
	dev-libs/libxslt
	>=dev-util/intltool-0.40
	virtual/pkgconfig
	doc? ( >=dev-util/gtk-doc-1.13 )"
PDEPEND="gtk? ( || ( >=gnome-extra/polkit-gnome-${PV} lxde-base/lxpolkit ) )
	kde? ( sys-auth/polkit-kde-agent )
	!systemd? (
		>=sys-auth/consolekit-0.4.5_p20120320[policykit]
		pam? ( >=sys-auth/pambase-20101024-r2[consolekit] )
		)"

DOCS=( docs/TODO HACKING NEWS README )

src_prepare() {
	cat <<-EOF > "${T}"/60-gentoo.conf
	# This file will override 50-localauthority.conf, see:
	# man 8 pklocalauthority
	[Configuration]
	AdminIdentities=unix-group:0
	EOF
}

src_configure() {
	local myauth="--with-authfw=shadow"
	use pam && myauth="--with-authfw=pam --with-pam-module-dir=$(getpam_mod_dir)"

	econf \
		--localstatedir="${EPREFIX}"/var \
		--disable-static \
		$(use_enable debug verbose-mode) \
		--enable-man-pages \
		$(use_enable doc gtk-doc) \
		$(use_enable systemd) \
		$(use_enable introspection) \
		--disable-examples \
		$(use_enable nls) \
		--with-os-type=gentoo \
		${myauth}
}

src_install() {
	default

	insinto /etc/polkit-1/localauthority.conf.d
	doins "${T}"/60-gentoo.conf

	find "${ED}" -name '*.la' -exec rm -f {} +

	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins src/examples/{*.c,*.policy*}
	fi

	diropts -m0700 -o root -g root
	keepdir /var/lib/polkit-1
}
