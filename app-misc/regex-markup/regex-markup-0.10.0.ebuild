# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/regex-markup/regex-markup-0.10.0.ebuild,v 1.3 2008/05/11 14:00:00 maekke Exp $

DESCRIPTION="A tool to color syslog files as well"
HOMEPAGE="http://www.nongnu.org/regex-markup/"
SRC_URI="http://savannah.nongnu.org/download/regex-markup/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="examples"

DEPEND=""

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	if use examples; then
		cd examples
		make -f Makefile
		cd ..
	fi
	dodoc AUTHORS ChangeLog NEWS README TODO
}
