# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/xdm/xdm-1.1.6-r1.ebuild,v 1.4 2008/03/05 18:54:02 fmccor Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit multilib x-modular pam

DEFAULTVT="vt7"

DESCRIPTION="X.Org xdm application"

KEYWORDS="~hppa ~sparc ~x86"
IUSE="xprint ipv6 pam"

RDEPEND="x11-libs/libXdmcp
	x11-libs/libXaw
	>=x11-apps/xinit-1.0.2-r3
	x11-libs/libXinerama
	x11-libs/libX11
	x11-libs/libXt
	pam? ( virtual/pam )"
DEPEND="${RDEPEND}
	x11-proto/xineramaproto
	x11-proto/xproto"

RDEPEND="${RDEPEND}
	x11-apps/xrdb
	x11-apps/sessreg
	pam? ( sys-auth/pambase )"

PATCHES="${FILESDIR}/wtmp.patch
	${FILESDIR}/xwilling-hang.patch"

CONFIGURE_OPTIONS="$(use_enable xprint)
	$(use_enable ipv6)
	$(use_with pam)
	--with-default-vt=${DEFAULTVT}
	--with-xdmconfigdir=/etc/X11/xdm"

pkg_setup() {
	if use xprint && ! built_with_use x11-libs/libXaw xprint; then
		die "Build x11-libs/libXaw with USE=xprint."
	fi
}

src_install() {
	x-modular_src_install
	exeinto /usr/$(get_libdir)/X11/xdm
	doexe "${FILESDIR}"/Xsession
	pamd_mimic system-local-login xdm auth account session
}

pkg_preinst() {
	x-modular_pkg_preinst

	# Check for leftover /usr/lib/X11/xdm symlink
	if [[ -L "/usr/lib/X11/xdm" ]]; then
		ewarn "/usr/lib/X11/xdm is a symlink; deleting."
		rm /usr/lib/X11/xdm
	fi
}
