# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/digest-bubblebabble/digest-bubblebabble-0.01.ebuild,v 1.1 2003/06/23 17:38:13 mcummings Exp $

inherit perl-module

MY_P=Digest-BubbleBabble-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Create bubble-babble fingerprints"
SRC_URI="http://search.cpan.org/CPAN/authors/id/B/BT/BTROTT/${MY_P}.tar.gz"
HOMEPAGE="http://search.cpan.org/CPAN/authors/id/B/BT/BTROTT/${MY_P}.readme"

SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="x86 ~alpha ~ppc ~sparc"

