# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/digest-bubblebabble/digest-bubblebabble-0.01.ebuild,v 1.5 2004/05/30 15:50:33 kloeri Exp $

inherit perl-module

MY_P=Digest-BubbleBabble-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Create bubble-babble fingerprints"
HOMEPAGE="http://search.cpan.org/CPAN/authors/id/B/BT/BTROTT/${MY_P}.readme"
SRC_URI="http://search.cpan.org/CPAN/authors/id/B/BT/BTROTT/${MY_P}.tar.gz"

LICENSE="Artistic | GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc alpha hppa ~amd64 ~mips"
