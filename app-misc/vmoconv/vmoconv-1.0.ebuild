# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/vmoconv/vmoconv-1.0.ebuild,v 1.1 2005/01/08 01:24:47 ticho Exp $

DESCRIPTION="A tool that converts Siemens phones VMO and VMI audio files to gsm and wav."
HOMEPAGE="http://triq.net/obex/"
SRC_URI="http://triq.net/obexftp/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="virtual/libc"

src_compile() {
	econf || die
	# ugly workaround, otherwise make tries to build binaries before
	# necessary .la file is built
	cd src && make libgsm.la || die
	cd ..
	emake || die
}

src_install() {
	dobin src/vmo2gsm src/gsm2vmo src/vmo2wav
	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README THANKS
}
