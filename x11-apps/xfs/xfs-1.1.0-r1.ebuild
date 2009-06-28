# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/xfs/xfs-1.1.0-r1.ebuild,v 1.1 2009/06/28 17:56:55 remi Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="X font server"

KEYWORDS="~alpha ~amd64 ~arm ~hppa ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE="doc ipv6 syslog xinetd"

RDEPEND="x11-libs/libFS
	x11-libs/libXfont
	syslog? ( virtual/logger )
	xinetd? ( virtual/inetd )"
DEPEND="${RDEPEND}
	x11-proto/fontsproto
	doc? ( dev-tex/xmltex )"

pkg_setup() {
	CONFIGURE_OPTIONS="$(use_enable ipv6) $(use_enable doc devel-docs)
	$(use_enable syslog) $(use_enable xinetd inetd) --libdir=/etc"
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
