# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-auth/consolekit/consolekit-0.4.5-r3.ebuild,v 1.1 2012/03/20 07:39:06 ssuominen Exp $

EAPI=4
inherit autotools eutils linux-info pam systemd

MY_PN=ConsoleKit
MY_P=${MY_PN}-${PV}

DESCRIPTION="Framework for defining and tracking users, login sessions and seats."
HOMEPAGE="http://www.freedesktop.org/wiki/Software/ConsoleKit"
SRC_URI="http://www.freedesktop.org/software/${MY_PN}/dist/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~mips ~ppc ~ppc64 ~sh ~x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~ia64-linux ~x86-linux"
IUSE="acl debug doc kernel_linux pam policykit test"

RDEPEND=">=dev-libs/dbus-glib-0.98
	>=dev-libs/glib-2.22
	sys-libs/zlib
	x11-libs/libX11
	kernel_linux? ( acl? ( sys-apps/acl >=sys-fs/udev-182 ) )
	pam? ( virtual/pam )
	policykit? ( >=sys-auth/polkit-0.101-r1 )
	!<sys-fs/udev-182"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-libs/libxslt
	doc? ( app-text/xmlto )
	test? ( app-text/docbook-xml-dtd:4.1.2 )"

S=${WORKDIR}/${MY_P}

pkg_setup() {
	# This is required to get login-session-id string with pam_ck_connector.so
	if use pam && use kernel_linux; then
		CONFIG_CHECK="~AUDITSYSCALL"
		linux-info_pkg_setup
	fi
}

src_prepare() {
	epatch \
		"${FILESDIR}"/${PN}-0.2.10-cleanup_console_tags.patch \
		"${FILESDIR}"/${PN}-0.4.0-polkit-automagic.patch \
		"${FILESDIR}"/${PN}-0.4.1-shutdown-reboot-without-policies.patch \
		"${FILESDIR}"/${PN}-0.4.5-udev-acl.patch \
		"${FILESDIR}"/${PN}-0.4.5-udev-acl-missing-AC_SUBST.patch \
		"${FILESDIR}"/${PN}-0.4.5-udev-acl-install_to_usr_and_missing_seat_d_symlink.patch

	eautoreconf
}

src_configure() {
	local myconf
	use kernel_linux && myconf="$(use_enable acl udev-acl)"

	econf \
		XMLTO_FLAGS="--skip-validation" \
		--localstatedir="${EPREFIX}"/var \
		$(use_enable pam pam-module) \
		$(use_enable doc docbook-docs) \
		$(use_enable debug) \
		$(use_enable policykit polkit) \
		--with-dbus-services="${EPREFIX}"/usr/share/dbus-1/services \
		--with-pam-module-dir=$(getpam_mod_dir) \
		"$(systemd_with_unitdir)" \
		${myconf}
}

src_install() {
	emake \
		DESTDIR="${D}" \
		htmldocdir="${EPREFIX}"/usr/share/doc/${PF}/html \
		install

	dodoc AUTHORS ChangeLog HACKING NEWS README TODO

	newinitd "${FILESDIR}"/${PN}-0.2.rc consolekit

	keepdir /usr/lib/ConsoleKit/run-seat.d
	keepdir /usr/lib/ConsoleKit/run-session.d
	keepdir /etc/ConsoleKit/run-session.d
	keepdir /var/log/ConsoleKit

	exeinto /etc/X11/xinit/xinitrc.d
	newexe "${FILESDIR}"/90-consolekit-3 90-consolekit

	exeinto /usr/lib/ConsoleKit/run-session.d
	doexe "${FILESDIR}"/pam-foreground-compat.ck

	find "${ED}" -name '*.la' -exec rm -f {} +
}
