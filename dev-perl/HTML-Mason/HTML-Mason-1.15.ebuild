# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/HTML-Mason/HTML-Mason-1.15.ebuild,v 1.2 2002/11/18 02:15:38 mkennedy Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="A HTML development and delivery Perl Module"
SRC_URI="http://www.masonhq.com/download/${P}.tar.gz"
HOMEPAGE="http://www.masonhq.com/"

SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="x86 ppc sparc sparc64 alpha"

DEPEND="${DEPEND}
	>=dev-perl/libapreq-1.0-r2
	>=dev-perl/Params-Validate-0.24-r1
	>=dev-perl/Class-Container-0.08
	>=dev-perl/Exception-Class-1.07
	>=dev-perl/Cache-Cache-1.01"

mydoc="CREDITS UPGRADE"

src_install () {
	perl-module_src_install
    dohtml htdocs/*
}
