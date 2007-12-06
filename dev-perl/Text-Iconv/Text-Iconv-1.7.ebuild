# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Text-Iconv/Text-Iconv-1.7.ebuild,v 1.2 2007/12/06 16:53:16 armin76 Exp $

inherit perl-module

DESCRIPTION="A Perl interface to the iconv() codeset conversion function"
HOMEPAGE="http://search.cpan.org/~mpiotr"
SRC_URI="mirror://cpan/authors/id/M/MP/MPIOTR/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="alpha ~amd64 ~arm ~hppa ia64 ~mips ~ppc ~ppc64 ~s390 ~sh sparc x86 ~x86-fbsd"
IUSE=""

DEPEND="dev-lang/perl"
