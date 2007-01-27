# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/regex-markup/regex-markup-0.10.0.ebuild,v 1.1 2007/01/27 10:58:31 masterdriverz Exp $

DESCRIPTION="A tool to color syslog files as well"
HOMEPAGE="http://www.nongnu.org/regex-markup/"
SRC_URI="http://savannah.nongnu.org/download/regex-markup/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc"
IUSE="examples"

DEPEND=""

src_install() {
	make DESTDIR=${D} install || die "make install failed"
	if use examples; then
		make -f examples/Makefile
	fi
	dodoc AUTHORS ChangeLog NEWS README TODO
}
