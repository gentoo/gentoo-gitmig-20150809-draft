# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmswallow/wmswallow-0.6.1.ebuild,v 1.1 2003/07/17 02:49:11 raker Exp $

IUSE=""

DESCRIPTION="A dock applet to make any application dockable."
HOMEPAGE="http://burse.uni-hamburg.de/~friedel/software/wmswallow.html"
SRC_URI="http://burse.uni-hamburg.de/~friedel/software/${PN}/${PN}.tar.Z"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="x11-base/xfree"

S=${WORKDIR}/wmswallow

src_compile() {
	make xfree || die
}

src_install() {
	insinto /usr/bin
	doins wmswallow
	fperms 755 /usr/bin/wmswallow
	dodoc CHANGELOG INSTALL LICENSE README README.solaris todo
}

