# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-util/injectso/injectso-0.2.ebuild,v 1.1 2002/08/19 03:07:38 blocke Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Inject shared libraries into running processes under Solaris and Linux"
HOMEPAGE="http://www.securereality.com.au/"
SRC_URI="http://www.securereality.com.au/archives/${P}.tar.gz"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND="virtual/glibc"

src_compile() {

	econf || die
	emake || die

}

src_install() {

	dobin injectso

	dodir /usr/lib/injectso
	insinto /usr/lib/injectso
	doins libtest.so libtest.c

	dodoc ChangeLog README.txt
	dohtml README.html

}

pkg_postinst() {

   einfo
   einfo Read the documentation for instructions on how to use this tool.
   einfo The sample library \"libtest.so\" and its source file \"libtest.c\"
   einfo be found in /usr/lib/injectso.
   einfo

}

