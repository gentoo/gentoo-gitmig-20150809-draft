# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/pgaccess/pgaccess-0.99.0.20040219-r2.ebuild,v 1.5 2010/01/07 05:17:39 josejx Exp $

inherit eutils

MY_P=${P//./_}

DESCRIPTION="a database frontend for postgresql"
HOMEPAGE="http://sourceforge.net/projects/pgaccess/"
SRC_URI="mirror://sourceforge/pgaccess/${MY_P}.tgz"
LICENSE="POSTGRESQL"

SLOT="0"
KEYWORDS="amd64 ppc ~x86"
IUSE=""

S=${WORKDIR}/${MY_P}

DEPEND=""

RDEPEND=">=dev-lang/tcl-8.3.4
	>=dev-lang/tk-8.3.4
	>=virtual/postgresql-server-7.3
	dev-tcltk/tcllib"

src_compile() {
	epatch "${FILESDIR}"/${P}.patch
	epatch "${FILESDIR}"/${P}-tcl8.5.patch
}

src_install() {
	make prefix="${D}" bindir="${D}"/usr/bin install || die
	rm -rf "${D}"/usr/lib/pgaccess/win32 \
		"${D}"/usr/lib/pgaccess/Makefile
	rm -rf "${D}"/usr/lib/pgaccess/osx
	dodir /usr/share/doc/${PF}
	mv "${D}"/usr/lib/pgaccess/{README,changelog,demo,doc/html,todo} "${D}"/usr/share/doc/${PF}
	rmdir "${D}"/usr/lib/pgaccess/doc
}

pkg_postinst() {
	einfo "When running the program, if you encount the error "
	einfo "\"Error: Shared library file: '/usr/lib/libpgtcl.so' does not exist.\","
	einfo "you need to emerge postgresql with USE='tcltk' again"
}
