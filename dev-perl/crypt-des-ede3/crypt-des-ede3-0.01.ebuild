# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/crypt-des-ede3/crypt-des-ede3-0.01.ebuild,v 1.5 2004/05/27 23:05:01 kloeri Exp $

inherit perl-module

MY_P=Crypt-DES_EDE3-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Triple-DES EDE encryption/decruption"
HOMEPAGE="http://search.cpan.org/CPAN/authors/id/B/BT/BTROTT/${MY_P}.readme"
SRC_URI="http://search.cpan.org/CPAN/authors/id/B/BT/BTROTT/${MY_P}.tar.gz"

LICENSE="Artistic | GPL-2"
SLOT="0"
KEYWORDS="x86 alpha ~ppc ~sparc hppa ~amd64 ~mips"

DEPEND="dev-perl/Crypt-DES"
