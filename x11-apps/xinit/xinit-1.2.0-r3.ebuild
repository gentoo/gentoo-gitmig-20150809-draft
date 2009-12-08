# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/xinit/xinit-1.2.0-r3.ebuild,v 1.1 2009/12/08 22:14:12 remi Exp $

EAPI="2"

inherit x-modular pam

DESCRIPTION="X Window System initializer"

LICENSE="${LICENSE} GPL-2"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="+minimal pam"

RDEPEND="
	x11-apps/xauth
	x11-libs/libX11
"
DEPEND="${RDEPEND}"
PDEPEND="x11-apps/xrdb
	!minimal? (
		x11-apps/xclock
		x11-apps/xsm
		x11-terms/xterm
		x11-wm/twm
	)
"

PATCHES=(
	"${FILESDIR}/0001-Gentoo-specific-customizations.patch"
)

pkg_setup() {
	CONFIGURE_OPTIONS="--with-xinitdir=/etc/X11/xinit"
}

src_install() {
	x-modular_src_install
	exeinto /etc/X11
	doexe "${FILESDIR}"/chooser.sh "${FILESDIR}"/startDM.sh || die
	exeinto /etc/X11/Sessions
	doexe "${FILESDIR}"/Xsession || die
	exeinto /etc/X11/xinit
	doexe "${FILESDIR}"/xserverrc || die
	newinitd "${FILESDIR}"/xdm.initd-4 xdm || die
	newinitd "${FILESDIR}"/xdm-setup.initd-1 xdm-setup || die
	newconfd "${FILESDIR}"/xdm.confd-2 xdm || die
	newpamd "${FILESDIR}"/xserver.pamd xserver
	dodir /etc/X11/xinit/xinitrc.d
	exeinto /etc/X11/xinit/xinitrc.d/
	doexe "${FILESDIR}/00-xhost"
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
