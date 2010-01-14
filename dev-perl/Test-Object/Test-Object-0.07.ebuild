# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Test-Object/Test-Object-0.07.ebuild,v 1.5 2010/01/14 14:50:41 grobian Exp $

inherit perl-module

DESCRIPTION="Thoroughly testing objects via registered handlers"
HOMEPAGE="http://search.cpan.org/dist/${PN}"
SRC_URI="mirror://cpan/authors/id/A/AD/ADAMK/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="amd64 ~ppc sparc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris"
IUSE=""

SRC_TEST="do"

DEPEND="dev-lang/perl
		virtual/perl-File-Spec
		virtual/perl-Scalar-List-Utils
		virtual/perl-Test-Simple"
