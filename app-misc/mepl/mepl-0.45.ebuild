# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/mepl/mepl-0.45.ebuild,v 1.9 2009/01/11 16:58:35 phosphan Exp $

inherit toolchain-funcs

DESCRIPTION="Self-employed-mode software for 3COM/USR message modems"
HOMEPAGE="http://www.hof-berlin.de/mepl/"
SRC_URI="http://www.hof-berlin.de/mepl/mepl${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc x86"
IUSE=""

DEPEND="virtual/libc"

S=${WORKDIR}/${PN}${PV}

src_unpack() {
	unpack ${A}
	cd "${S}"
	echo "#include <stdlib.h>" > tmpmepl.c
	cat mepl.c >> tmpmepl.c
	mv tmpmepl.c mepl.c
}

src_compile() {
	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS} -DMEPLCONFIG=\\\"/etc/mepl.conf\\\"" en || die
}

src_install() {
	dobin mepl meplmail || die
	insinto /etc
	doins mepl.conf
	newman mepl.en mepl.7
}
