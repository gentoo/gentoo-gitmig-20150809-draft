# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-NamespaceSupport/XML-NamespaceSupport-1.09.ebuild,v 1.18 2010/01/21 12:37:20 tove Exp $

inherit perl-module

DESCRIPTION="A Perl module that offers a simple to process namespaced XML names"
HOMEPAGE="http://search.cpan.org/~rberjon/"
SRC_URI="mirror://cpan/authors/id/R/RB/RBERJON/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE=""

DEPEND=">=dev-libs/libxml2-2.4.1
	dev-lang/perl"

SRC_TEST="do"
