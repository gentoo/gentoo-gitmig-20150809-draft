# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/crypt-cbc/crypt-cbc-2.08.ebuild,v 1.1 2003/06/24 00:45:24 mcummings Exp $

inherit perl-module

MY_P=Crypt-CBC-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Encrypt Data with Cipher Block Chaining Mode"
SRC_URI="http://search.cpan.org/CPAN/authors/id/L/LD/LDS/${MY_P}.tar.gz"
HOMEPAGE="http://search.cpan.org/CPAN/authors/id/L/LD/LDS/${MY_P}.readme"

SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="x86 ~alpha ~ppc ~sparc"

DEPEND="dev-perl/Digest-MD5"
