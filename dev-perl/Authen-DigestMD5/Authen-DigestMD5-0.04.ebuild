# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Authen-DigestMD5/Authen-DigestMD5-0.04.ebuild,v 1.2 2004/06/25 00:07:56 agriffis Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="SASL DIGEST-MD5 authentication (RFC2831)"
SRC_URI="http://cpan.org/modules/by-category/14_Security_and_Encryption/Authen/${P}.tar.gz"
HOMEPAGE="http://cpan.org/modules/by-module/Authen/"

SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc ~alpha"

DEPEND="${DEPEND}"

export OPTIMIZE="$CFLAGS"

