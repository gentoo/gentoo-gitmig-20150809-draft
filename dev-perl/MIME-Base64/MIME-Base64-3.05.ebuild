# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/MIME-Base64/MIME-Base64-3.05.ebuild,v 1.5 2004/10/29 11:58:51 kloeri Exp $

inherit perl-module

DESCRIPTION="A base64/quoted-printable encoder/decoder Perl Modules"
HOMEPAGE="http://search.cpan.org/~gaas/${P}/"
SRC_URI="mirror://cpan/authors/id/G/GA/GAAS/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="x86 ppc sparc ~mips alpha ~arm ~hppa ~amd64 ~ia64 ~s390 ~ppc64"
IUSE=""

SRC_TEST="do"
