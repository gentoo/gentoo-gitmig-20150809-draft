# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/xdm/xdm-0.99.1_pre20050905-r1.ebuild,v 1.1 2005/09/06 19:36:27 joshuabaergen Exp $

inherit versionator

# Must be before x-modular eclass is inherited
SNAPSHOT="yes"

# Fix ${S} in x-modular for pre ebuilds
MY_P="${PN}-$(get_version_component_range 1-3)"
S="${WORKDIR}/${MY_P}"

inherit x-modular pam

DESCRIPTION="X.Org xdm application"
KEYWORDS="~amd64 ~arm ~ppc ~s390 ~sh ~sparc ~x86"
IUSE="xprint ipv6 pam"
RDEPEND="x11-libs/libXdmcp
	x11-libs/libXaw
	>=x11-apps/xinit-0.99.1_pre20050905-r1"
DEPEND="${RDEPEND}
	x11-proto/xproto"

# Snapshots don't reside on fdo servers
SRC_URI="mirror://gentoo/${P}.tar.bz2"

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
	newpamd ${FILESDIR}/xdm.pamd xdm
}
