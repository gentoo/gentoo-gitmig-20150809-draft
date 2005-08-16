# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/xdm/xdm-0.99.0-r1.ebuild,v 1.1 2005/08/16 02:53:03 spyderous Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="X.Org xdm application"
KEYWORDS="~sparc ~x86"
IUSE="xprint ipv6 pam"
RDEPEND="x11-libs/libXdmcp
	x11-libs/libXaw"
DEPEND="${RDEPEND}
	x11-proto/xproto"

CONFIGURE_OPTIONS="$(use_enable xprint)
	$(use_enable ipv6)
	$(use_with pam)"

pkg_setup() {
	if use xprint && ! built_with_use x11-libs/libXaw xprint; then
		die "Build x11-libs/libXaw with USE=xprint."
	fi
}

src_install() {
	x-modular_src_install
	exeinto /etc/X11/xdm
	doexe ${FILESDIR}/Xsession
	newinitd ${FILESDIR}/xdm.start xdm
	insinto /etc/pam.d
	newins ${FILESDIR}/xdm.pamd xdm
}
