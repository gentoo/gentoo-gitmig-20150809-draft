# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/HTML-Mason/HTML-Mason-1.0-r2.ebuild,v 1.4 2003/02/13 11:09:02 vapier Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="A HTML development and delivery Perl Module"
SRC_URI="http://www.masonhq.com/download/${P}.tar.gz"
HOMEPAGE="http://www.masonhq.com/"

SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="x86 ppc sparc alpha"

DEPEND="${DEPEND}
	dev-perl/Time-HiRes
	dev-perl/MLDBM"

mydoc="CREDITS UPGRADE"

src_install () {
	
	perl-module_src_install
    dohtml htdocs/*

}
