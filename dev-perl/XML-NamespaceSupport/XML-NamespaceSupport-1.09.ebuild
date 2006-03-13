# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-NamespaceSupport/XML-NamespaceSupport-1.09.ebuild,v 1.10 2006/03/13 22:19:16 gustavoz Exp $

inherit perl-module

DESCRIPTION="A Perl module that offers a simple to process namespaced XML names"
SRC_URI="mirror://cpan/authors/id/R/RB/RBERJON/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~rberjon/${P}"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="alpha amd64 hppa ia64 ~mips ppc ppc64 sparc x86"
IUSE=""

SRC_TEST="do"

DEPEND="${DEPEND}
	>=dev-libs/libxml2-2.4.1"
