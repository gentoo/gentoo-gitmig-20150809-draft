# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/bfr/bfr-1.5.ebuild,v 1.2 2003/10/08 03:38:45 hillster Exp $

DESCRIPTION="Buffer (bfr) is a general-purpose command-line pipe buffer. It buffers data from stdin and sends it to stdout, adjusting to best fit the pace stdout can handle."
HOMEPAGE="http://www.glines.org:8000/software/buffer.html"
SRC_URI="http://www.glines.org:8000/bin/pk/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""
DEPEND=""

S=${WORKDIR}/${P}

src_compile() {
	econf || die "configure failed"
	emake || die "compile failed"
}

src_install() {
	einstall || die "install failed"
	dodoc AUTHORS COPYING INSTALL Changelog NEWS README TODO
}
