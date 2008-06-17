# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/cddetect/cddetect-2.0.ebuild,v 1.1 2008/06/17 13:45:09 drac Exp $

inherit toolchain-funcs

DESCRIPTION="Detects CD/DVD media types without mounting them. At least Audio, ISO, VCD, SVCD, and VDVD are supported."
HOMEPAGE="http://www.bellut.net/projects.html#cddetect"
SRC_URI="http://www.bellut.net/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

S=${WORKDIR}

src_unpack() {
	unpack ${A}
	sed -i -e 's:#include <stdlib.h>:#include <stdlib.h>\n#include <stddef.h>:' \
		"${S}"/${PN}.c || die "sed failed."
}

src_compile() {
	$(tc-getCC) ${CFLAGS} ${LDFLAGS} ${PN}.c -o ${PN} || die "compile failed."
}

src_install() {
	dobin ${PN} || die "dobin failed."
}
