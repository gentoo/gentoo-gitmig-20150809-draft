# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/emul-linux-x86-opengl/emul-linux-x86-opengl-20110129-r1.ebuild,v 1.3 2011/09/17 19:04:19 mattst88 Exp $

inherit emul-linux-x86

LICENSE="BSD LGPL-2 MIT"

KEYWORDS="-* amd64 ~amd64-linux"

DEPEND="app-admin/eselect-opengl
	>=app-admin/eselect-mesa-0.0.9"
RDEPEND=">=app-emulation/emul-linux-x86-xlibs-20100611
	!<app-emulation/emul-linux-x86-xlibs-20100611
	media-libs/mesa"

src_unpack() {
	emul-linux-x86_src_unpack
	rm -f "${S}/usr/lib32/libGL.so" || die
}

pkg_postinst() {
	# Update GL symlinks
	eselect opengl set --use-old || die
	# And the same for mesa (bug #355393)
	eselect mesa set 32bit --auto || die
}
