# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Crypt-Twofish/Crypt-Twofish-2.12.ebuild,v 1.1 2005/04/11 16:38:46 mcummings Exp $

inherit perl-module

DESCRIPTION="The Twofish Encryption Algorithm"
HOMEPAGE="http://search.cpan.org/~ams/${P}/"
SRC_URI="mirror://cpan/authors/id/A/AM/AMS/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~x86 ~sparc"
IUSE=""

SRC_TEST="do"
