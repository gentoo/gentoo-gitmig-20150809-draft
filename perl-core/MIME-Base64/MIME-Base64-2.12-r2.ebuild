# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/MIME-Base64/MIME-Base64-2.12-r2.ebuild,v 1.2 2006/08/04 13:27:06 mcummings Exp $

inherit perl-module

DESCRIPTION="A base64/quoted-printable encoder/decoder Perl Modules"
SRC_URI="mirror://cpan/authors/id/G/GA/GAAS/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~gaas/${P}/"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="x86 amd64 ppc sparc alpha hppa"
IUSE=""

DEPEND="dev-lang/perl"
