# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/tie-encryptedhash/tie-encryptedhash-1.21.ebuild,v 1.15 2006/08/06 03:14:10 mcummings Exp $

inherit perl-module

MY_P=Tie-EncryptedHash-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Hashes (and objects based on hashes) with encrypting fields."
HOMEPAGE="http://search.cpan.org/CPAN/authors/id/V/VI/VIPUL/${MY_P}.readme"
SRC_URI="mirror://cpan/authors/id/V/VI/VIPUL/${MY_P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ~mips ~ppc sparc x86"
IUSE=""

DEPEND="dev-perl/Crypt-Blowfish
	dev-perl/Crypt-DES
	dev-perl/crypt-cbc
	dev-lang/perl"
RDEPEND="${DEPEND}"


