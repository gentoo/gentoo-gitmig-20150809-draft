# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-perl/HTML-SimpleParse/HTML-SimpleParse-0.11.ebuild,v 1.1 2003/06/08 03:28:16 mcummings Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="A bare-bones HTML parser, similar to HTML::Parser, but with a couple important distinctions."
SRC_URI="http://www.cpan.org/authors/id/K/KW/KWILLIAMS/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/authors/id/K/KW/KWILLIAMS/${P}.readme"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 ~ppc ~sparc alpha"
