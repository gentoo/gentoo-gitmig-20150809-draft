# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/crypt-cbc/crypt-cbc-2.11.ebuild,v 1.1 2004/06/05 16:31:46 mcummings Exp $

inherit perl-module

MY_P=Crypt-CBC-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Encrypt Data with Cipher Block Chaining Mode"
HOMEPAGE="http://search.cpan.org/CPAN/authors/id/L/LD/LDS/${MY_P}.readme"
SRC_URI="http://search.cpan.org/CPAN/authors/id/L/LD/LDS/${MY_P}.tar.gz"

LICENSE="Artistic | GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~amd64 ~mips"
SRC_TEST="do"

DEPEND="dev-perl/Digest-MD5"
