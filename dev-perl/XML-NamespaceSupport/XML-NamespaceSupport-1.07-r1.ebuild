# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-NamespaceSupport/XML-NamespaceSupport-1.07-r1.ebuild,v 1.11 2005/01/04 14:18:26 mcummings Exp $

inherit perl-module

DESCRIPTION="A Perl module that offers a simple to process namespaced XML names"
SRC_URI="mirror://cpan/authors/id/R/RB/RBERJON/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~rberjon/${P}"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 amd64 alpha sparc ppc"
IUSE=""

DEPEND="${DEPEND}
	>=dev-libs/libxml2-2.4.1"
