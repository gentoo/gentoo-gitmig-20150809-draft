# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Digest-MD5/Digest-MD5-2.20.ebuild,v 1.3 2002/07/25 04:13:25 seemant Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="A URI Perl Module"
SRC_URI="http://cpan.valueclick.com/modules/by-category/14_Security_and_Encryption/Digest/${P}.tar.gz"
HOMEPAGE="http://cpan.valueclick.com/modules/by-category/14_Security_and_Encryption/Digest/${P}.readme"

SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="x86"

mydoc="rfc*.txt"
