# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/nx-x11-bin/nx-x11-bin-1.5.0.ebuild,v 1.1 2006/04/30 17:21:26 stuart Exp $

inherit multilib eutils

DESCRIPTION="A special version of the X11 libraries supporting NX compression technology"
HOMEPAGE="http://www.nomachine.com/"

SRC_URI="http://svn.gnqs.org/svn/gentoo-nx-overlay/downloads/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="rdesktop vnc"

DEPEND="x86? ( ~net-misc/nxcomp-1.5.0 )
	amd64? (
		>=app-emulation/emul-linux-x86-baselibs-2.1.4
		>=app-emulation/emul-linux-x86-xlibs-2.2.1
	)
	!net-misc/nx-x11"

RDEPEND="${DEPEND}"

pkg_setup() {
	# This is a binary x86 package => ABI=x86
	has_multilib_profile && ABI="x86"
}

src_install() {
	into /usr/NX

	dobin nxagent
	dobin nxauth

	if use vnc ; then
		dobin nxviewer
		dobin nxpasswd
	fi

	if use rdesktop ; then
		dobin nxdesktop
	fi

	use x86 || dolib.so libXcomp.so*

	dolib.so libXcompext.so*

	dolib.so libX11.so*

	dolib.so libXext.so*

	dolib.so libXrender.so*
}
