# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/HTML-Mason/HTML-Mason-1.15.ebuild,v 1.1 2002/11/17 06:38:01 mkennedy Exp $

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
	>=Params-Validate-0.24-r1
	>=Class-Container-0.08
	>=Exception-Class-1.07"

mydoc="CREDITS UPGRADE"

src_install () {
	perl-module_src_install
    dohtml htdocs/*
}
