# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/xdm/xdm-1.0.3-r1.ebuild,v 1.1 2006/04/20 06:34:22 spyderous Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit multilib x-modular pam

DEFAULTVT="vt7"

DESCRIPTION="X.Org xdm application"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="xprint ipv6 pam"
RDEPEND="x11-apps/xrdb
	x11-libs/libXdmcp
	x11-libs/libXaw
	>=x11-apps/xinit-1.0.2-r2
	x11-libs/libX11
	x11-libs/libXt"
DEPEND="${RDEPEND}
	x11-proto/xproto"

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
	doexe ${FILESDIR}/Xsession
	newpamd ${FILESDIR}/xdm.pamd xdm
}

pkg_preinst() {
	x-modular_pkg_preinst

	# Check for leftover /usr/lib/X11/xdm symlink
	if [[ -L "/usr/lib/X11/xdm" ]]; then
		ewarn "/usr/lib/X11/xdm is a symlink; deleting."
		rm /usr/lib/X11/xdm
	fi
}
