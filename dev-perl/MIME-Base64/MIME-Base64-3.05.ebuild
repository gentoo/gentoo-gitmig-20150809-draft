# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/MIME-Base64/MIME-Base64-3.05.ebuild,v 1.10 2005/01/22 06:21:13 vapier Exp $

inherit perl-module

DESCRIPTION="A base64/quoted-printable encoder/decoder Perl Modules"
HOMEPAGE="http://search.cpan.org/~gaas/${P}/"
SRC_URI="mirror://cpan/authors/id/G/GA/GAAS/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ~ppc64 s390 sparc x86"
IUSE=""

SRC_TEST="do"
