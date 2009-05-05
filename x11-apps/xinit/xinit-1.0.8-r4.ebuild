# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/xinit/xinit-1.0.8-r4.ebuild,v 1.10 2009/05/05 08:24:54 fauli Exp $

# Must be before x-modular eclass is inherited
# This is enabled due to modified Makefile.am from the patches
SNAPSHOT="yes"

inherit x-modular pam

DESCRIPTION="X Window System initializer"

LICENSE="${LICENSE} GPL-2"
KEYWORDS="~alpha amd64 ~arm hppa ia64 ~mips ppc ppc64 ~s390 sh sparc x86 ~x86-fbsd"
IUSE="hal minimal pam"

RDEPEND="x11-apps/xauth
	x11-libs/libX11
	hal? ( sys-auth/consolekit )"
DEPEND="${RDEPEND}"
PDEPEND="!minimal? ( x11-wm/twm
				x11-apps/xclock
				x11-apps/xrdb
				x11-apps/xsm
				x11-terms/xterm )"

PATCHES=( "${FILESDIR}"/nolisten-tcp-and-black-background.patch
	"${FILESDIR}"/gentoo-startx-customization-1.0.8.patch
	"${FILESDIR}"/xinit-1.0.4-console-kit.patch )

pkg_setup() {
	CONFIGURE_OPTIONS="$(use_with hal consolekit)"
	if use hal; then
		if ! built_with_use sys-apps/dbus X ; then
			eerror "You MUST build sys-apps/dbus with the X USE flag enabled."
			die "You MUST build sys-apps/dbus with the X USE flag enabled."
		fi
	fi
}

src_unpack() {
	x-modular_unpack_source
	x-modular_patch_source

	sed -i -e "s:^XINITDIR.*:XINITDIR = \$(sysconfdir)/X11/xinit:g" "${S}/Makefile.am"

	x-modular_reconf_source
}

src_install() {
	x-modular_src_install
	exeinto /etc/X11
	doexe "${FILESDIR}"/chooser.sh "${FILESDIR}"/startDM.sh || die
	exeinto /etc/X11/Sessions
	doexe "${FILESDIR}"/Xsession || die
	exeinto /etc/X11/xinit
	doexe "${FILESDIR}"/xinitrc || die
	newinitd "${FILESDIR}"/xdm.initd-2 xdm
	newconfd "${FILESDIR}"/xdm.confd-1 xdm
	newpamd "${FILESDIR}"/xserver.pamd xserver
}

pkg_postinst() {
	x-modular_pkg_postinst
	ewarn "If you use startx to start X instead of a login manager like gdm/kdm,"
	ewarn "you can set the XSESSION variable to anything in /etc/X11/Sessions/ or"
	ewarn "any executable. When you run startx, it will run this as the login session."
	ewarn "You can set this in a file in /etc/env.d/ for the entire system,"
	ewarn "or set it per-user in ~/.bash_profile (or similar for other shells)."
	ewarn "Here's an example of setting it for the whole system:"
	ewarn "    echo XSESSION=\"Gnome\" > /etc/env.d/90xsession"
	ewarn "    env-update && source /etc/profile"
}
