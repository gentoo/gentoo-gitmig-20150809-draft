# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Authen-DigestMD5/Authen-DigestMD5-0.04.ebuild,v 1.7 2005/01/13 02:15:51 gustavoz Exp $

inherit perl-module

DESCRIPTION="SASL DIGEST-MD5 authentication (RFC2831)"
SRC_URI="mirror://cpan/authors/id/S/SA/SALVA/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~salva/${P}/"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="x86 ~amd64 ~ppc sparc ~alpha ~ppc64"
IUSE=""

SRC_TEST="do"

export OPTIMIZE="$CFLAGS"
