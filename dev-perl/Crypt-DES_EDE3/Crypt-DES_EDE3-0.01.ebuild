# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Crypt-DES_EDE3/Crypt-DES_EDE3-0.01.ebuild,v 1.2 2006/01/13 19:44:25 mcummings Exp $

inherit perl-module

DESCRIPTION="Triple-DES EDE encryption/decryption"
HOMEPAGE="http://search.cpan.org/~btrott/${P}/"
SRC_URI="mirror://cpan/authors/id/B/BT/BTROTT/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="sparc x86"
IUSE=""

SRC_TEST="do"

DEPEND="dev-perl/Crypt-DES"
