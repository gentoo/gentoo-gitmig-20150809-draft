# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/tie-encryptedhash/tie-encryptedhash-1.21.ebuild,v 1.4 2004/02/26 06:16:27 kumba Exp $

inherit perl-module

MY_P=Tie-EncryptedHash-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Hashes (and objects based on hashes) with encrypting fields."
HOMEPAGE="http://search.cpan.org/CPAN/authors/id/V/VI/VIPUL/${MY_P}.readme"
SRC_URI="http://search.cpan.org/CPAN/authors/id/V/VI/VIPUL/${MY_P}.tar.gz"

LICENSE="Artistic | GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc ~alpha hppa ~amd64 ~mips"

DEPEND="dev-perl/Crypt-Blowfish
	dev-perl/Crypt-DES
	dev-perl/crypt-cbc"
