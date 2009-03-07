# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/tofrodos/tofrodos-1.7.8.ebuild,v 1.1 2009/03/07 15:46:14 patrick Exp $

DESCRIPTION="text file conversion utility that converts ASCII files between the
MSDOS format and the Unix format"
HOMEPAGE="http://tofrodos.sourceforge.net/"
SRC_URI="http://tofrodos.sourceforge.net/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

S="${WORKDIR}/${PN}/src"

src_compile() {
	emake DEBUG=1 || die "Compile failed."
}

src_install() {
	dobin fromdos || die
	dosym fromdos /usr/bin/todos
	doman fromdos.1
}
