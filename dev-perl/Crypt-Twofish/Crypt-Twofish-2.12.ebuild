# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Crypt-Twofish/Crypt-Twofish-2.12.ebuild,v 1.5 2006/07/10 15:00:48 agriffis Exp $

inherit perl-module

DESCRIPTION="The Twofish Encryption Algorithm"
HOMEPAGE="http://search.cpan.org/~ams/${P}/"
SRC_URI="mirror://cpan/authors/id/A/AM/AMS/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~amd64 ia64 sparc x86"
IUSE=""

SRC_TEST="do"
