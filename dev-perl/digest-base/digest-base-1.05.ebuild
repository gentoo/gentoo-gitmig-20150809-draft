# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/digest-base/digest-base-1.05.ebuild,v 1.5 2004/01/06 04:04:47 brad_mssw Exp $

inherit perl-module

MY_P=Digest-${PV}
S=${WORKDIR}/${MY_P}

DESCRIPTION="MD5 message digest algorithm"
SRC_URI="http://www.cpan.org/modules/by-authors/id/G/GA/GAAS/${MY_P}.tar.gz"
HOMEPAGE="http://http://www.cpan.org/modules/by-authors/id/G/GA/GAAS/${MY_P}.readme"

SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="x86 amd64 ppc sparc alpha ~hppa" #~arm"

mydoc="rfc*.txt"

