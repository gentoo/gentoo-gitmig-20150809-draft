# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Crypt-Rijndael/Crypt-Rijndael-0.05.ebuild,v 1.12 2007/07/10 23:33:26 mr_bones_ Exp $

inherit perl-module eutils

DESCRIPTION="Crypt::CBC compliant Rijndael encryption module"
HOMEPAGE="http://search.cpan.org/~dido/${P}/"
SRC_URI="mirror://cpan/authors/id/D/DI/DIDO/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="amd64 hppa ia64 sparc x86"
IUSE=""

SRC_TEST="do"

src_unpack() {
	unpack ${A}
	use amd64 && cd ${S} && epatch ${FILESDIR}/crypt-rijndael-amd64.patch
}
DEPEND="dev-lang/perl"
