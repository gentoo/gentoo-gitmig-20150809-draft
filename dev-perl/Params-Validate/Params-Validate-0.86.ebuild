# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Params-Validate/Params-Validate-0.86.ebuild,v 1.4 2006/10/20 19:55:19 kloeri Exp $

inherit perl-module

DESCRIPTION="A module to provide a flexible system for validation method/function call parameters"
SRC_URI="mirror://cpan/authors/id/D/DR/DROLSKY/${P}.tar.gz"
HOMEPAGE="http://search.perl.com/~drolsky/${P}/"

SRC_TEST="do"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="alpha amd64 ia64 ~ppc ~ppc64 sparc ~x86"
IUSE=""

src_install () {
	perl-module_src_install
	dohtml htdocs/*
}


DEPEND="dev-lang/perl"
