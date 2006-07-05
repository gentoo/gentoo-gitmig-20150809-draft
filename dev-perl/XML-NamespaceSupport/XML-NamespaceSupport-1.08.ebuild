# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-NamespaceSupport/XML-NamespaceSupport-1.08.ebuild,v 1.12 2006/07/05 13:32:14 ian Exp $

inherit perl-module

DESCRIPTION="A Perl module that offers a simple to process namespaced XML names"
SRC_URI="mirror://cpan/authors/id/R/RB/RBERJON/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~rberjon/${P}"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="alpha amd64 ~mips ppc ppc64 sparc x86"
IUSE=""

DEPEND=">=dev-libs/libxml2-2.4.1"
RDEPEND="${DEPEND}"