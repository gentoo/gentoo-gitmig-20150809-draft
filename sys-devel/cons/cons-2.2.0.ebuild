# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2
# $Header: 

MY_P=${PN}-2.2.0
S=${WORKDIR}/${MY_P}
DESCRIPTION="Extensible perl-based build utility"
SRC_URI="http://www.dsmit.com/cons/stable/${MY_P}.tgz"
HOMEPAGE="http://www.dsmit.com/cons/"

DEPEND="sys-devel/perl
	dev-perl/Digest-MD5"

SLOT="2.2"
LICENSE="GPL"
KEYWORDS="x86 ~ppc ~sparc ~sparc64 ~alpha"

src_install () {
	exeinto /usr/bin
	doexe cons
	dodoc CHANGES COPYING COPYRIGHT INSTALL MANIFEST README RELEASE TODO
	dohtml *.html
	doman cons.1.gz
}
