# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/emul-linux-x86-xlibs/emul-linux-x86-xlibs-20100220.ebuild,v 1.2 2010/03/22 13:58:13 pacho Exp $

inherit emul-linux-x86

LICENSE="BSD FTL GPL-2 LGPL-2 MIT MOTIF"

KEYWORDS="-* amd64 ~amd64-linux"
IUSE="opengl"

DEPEND="opengl? ( app-admin/eselect-opengl )"
RDEPEND="~app-emulation/emul-linux-x86-baselibs-${PV}
	x11-libs/libX11
	opengl? ( media-libs/mesa )"

src_unpack() {
	emul-linux-x86_src_unpack
	rm -f "${S}/usr/lib32/libGL.so" || die
}

pkg_postinst() {
	#update GL symlinks
	use opengl && eselect opengl set --use-old
}
