# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/HTML-FillInForm/HTML-FillInForm-2.00.ebuild,v 1.1 2008/04/29 06:13:25 yuval Exp $

inherit perl-module

DESCRIPTION="Populates HTML Forms with data."
HOMEPAGE="http://search.cpan.org/~tjmather/${P}/"
SRC_URI="mirror://cpan/authors/id/T/TJ/TJMATHER/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~sparc ~x86 ~x86-fbsd"
IUSE=""

SRC_TEST="do"

DEPEND="dev-perl/HTML-Parser
        dev-lang/perl"
