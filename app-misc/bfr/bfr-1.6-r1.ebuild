# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/bfr/bfr-1.6-r1.ebuild,v 1.5 2009/04/13 02:29:32 mr_bones_ Exp $

inherit toolchain-funcs

DESCRIPTION="Buffer (bfr) is a general-purpose command-line pipe buffer"
HOMEPAGE="http://www.glines.org/software/buffer.html"
SRC_URI="http://www.glines.org/bin/pk/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc ppc64 sparc x86"
IUSE=""

DEPEND=""

pkg_setup() {
	tc-export CC
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
	dodoc AUTHORS INSTALL ChangeLog NEWS README TODO
}
