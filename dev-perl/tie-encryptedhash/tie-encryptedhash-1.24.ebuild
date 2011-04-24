# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/tie-encryptedhash/tie-encryptedhash-1.24.ebuild,v 1.3 2011/04/24 15:51:07 grobian Exp $

inherit perl-module

MY_P=Tie-EncryptedHash-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Hashes (and objects based on hashes) with encrypting fields."
HOMEPAGE="http://search.cpan.org/dist/Tie-EncryptedHash/"
SRC_URI="mirror://cpan/authors/id/V/VI/VIPUL/${MY_P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x86-solaris"
IUSE=""

DEPEND="dev-perl/Crypt-Blowfish
	dev-perl/Crypt-DES
	dev-perl/crypt-cbc
	dev-lang/perl"

SRC_TEST=do
