# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/HTML-Mason/HTML-Mason-1.0-r2.ebuild,v 1.1 2002/10/30 07:20:36 seemant Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="A HTML development and delivery Perl Module"
SRC_URI="http://www.masonhq.com/download/${P}.tar.gz"
HOMEPAGE="http://www.masonhq.com/"

SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="x86 ppc sparc sparc64 alpha"

DEPEND="${DEPEND}
	dev-perl/Time-HiRes
	dev-perl/MLDBM"

mydoc="CREDITS UPGRADE"

src_install () {
	
	perl-module_src_install
    dohtml htdocs/*

}
