# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/ck/ck-8.0.ebuild,v 1.6 2004/03/13 09:53:56 mr_bones_ Exp $

P_NEW=${PN}${PV}
S=${WORKDIR}/${P_NEW}

DESCRIPTION="A curses based toolkit for tcl"
HOMEPAGE="http://www.ch-werner.de/ck/"
SRC_URI="http://www.ch-werner.de/ck/${P_NEW}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="x86"
IUSE=""
DEPEND=">=dev-lang/tk-8.0
	>=sys-apps/sed-4"

src_compile() {
	local myconf="--with-tcl=/usr/lib --enable-shared"
	econf ${myconf}
	emake CFLAGS="${CFLAGS}" || die

	# patch Makefile
	sed -i -e "s:mkdir:mkdir -p:g"  \
		-e "s|install: |install: install-man |" Makefile
}

src_install() {
	dodoc README license.terms
	einstall || die "Failed to install."
}


