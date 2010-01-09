# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/crypt-des-ede3/crypt-des-ede3-0.01.ebuild,v 1.20 2010/01/09 19:03:30 grobian Exp $

inherit perl-module

MY_P=Crypt-DES_EDE3-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Triple-DES EDE encryption/decryption"
HOMEPAGE="http://search.cpan.org/~btrott/"
SRC_URI="mirror://cpan/authors/id/B/BT/BTROTT/${MY_P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ~mips ~ppc ppc64 sparc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE=""

DEPEND="dev-perl/Crypt-DES
	dev-lang/perl"
