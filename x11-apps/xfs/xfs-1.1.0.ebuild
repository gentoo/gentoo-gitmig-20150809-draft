# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/xfs/xfs-1.1.0.ebuild,v 1.1 2009/06/20 10:22:24 remi Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="X font server"

KEYWORDS="~alpha ~amd64 ~arm ~hppa ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE="ipv6"

RDEPEND="x11-apps/ttmkfdir
	x11-libs/libFS
	x11-libs/libXfont"
DEPEND="${RDEPEND}
	x11-proto/fontsproto"

pkg_setup() {
	CONFIGURE_OPTIONS="$(use_enable ipv6) --libdir=/etc"
	enewgroup xfs 33
	enewuser xfs 33 -1 /etc/X11/fs xfs
}

src_install() {
	x-modular_src_install

	insinto /etc/X11/fs
	newins "${FILESDIR}"/xfs.config config
	newinitd "${FILESDIR}"/xfs.start xfs
	newconfd "${FILESDIR}"/xfs.conf.d xfs
}
