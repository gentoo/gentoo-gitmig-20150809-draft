# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/HTML-SimpleParse/HTML-SimpleParse-0.12.ebuild,v 1.7 2005/04/09 02:11:59 gustavoz Exp $

inherit perl-module

DESCRIPTION="A bare-bones HTML parser, similar to HTML::Parser, but with a couple important distinctions."
HOMEPAGE="http://www.cpan.org/modules/by-module/HTML/${P}.readme"
SRC_URI="mirror://cpan/authors/id/K/KW/KWILLIAMS/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="x86 amd64 ~ppc sparc alpha ~ppc64"
IUSE=""

DEPEND="dev-perl/module-build"
