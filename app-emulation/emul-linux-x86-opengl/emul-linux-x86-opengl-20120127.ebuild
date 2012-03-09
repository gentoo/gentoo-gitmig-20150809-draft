# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/emul-linux-x86-opengl/emul-linux-x86-opengl-20120127.ebuild,v 1.2 2012/03/09 14:57:03 ssuominen Exp $

EAPI="4"

inherit emul-linux-x86

LICENSE="BSD LGPL-2 MIT"

KEYWORDS="-* amd64 ~amd64-linux"

DEPEND="app-admin/eselect-opengl
	>=app-admin/eselect-mesa-0.0.9"
RDEPEND=">=app-emulation/emul-linux-x86-xlibs-20100611
	!<app-emulation/emul-linux-x86-xlibs-20100611
	media-libs/mesa"

src_prepare() {
	emul-linux-x86_src_prepare
	rm -f "${S}/usr/lib32/libGL.so" || die
	rm -f "${S}/usr/lib32/libGL.so.1" || die
}

pkg_postinst() {
	# Update GL symlinks
	eselect opengl set --use-old || die
	# And the same for mesa (bug #355393)
	eselect mesa set 32bit --auto || die
}
