# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-NamespaceSupport/XML-NamespaceSupport-1.09.ebuild,v 1.15 2006/09/04 00:38:45 kumba Exp $

inherit perl-module

DESCRIPTION="A Perl module that offers a simple to process namespaced XML names"
HOMEPAGE="http://search.cpan.org/~rberjon/${P}"
SRC_URI="mirror://cpan/authors/id/R/RB/RBERJON/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 sh sparc x86 ~x86-fbsd"
IUSE=""

DEPEND=">=dev-libs/libxml2-2.4.1
	dev-lang/perl"
RDEPEND="${DEPEND}"

SRC_TEST="do"

