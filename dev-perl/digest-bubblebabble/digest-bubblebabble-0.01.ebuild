# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/digest-bubblebabble/digest-bubblebabble-0.01.ebuild,v 1.17 2007/07/10 23:33:28 mr_bones_ Exp $

inherit perl-module

MY_P=Digest-BubbleBabble-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Create bubble-babble fingerprints"
HOMEPAGE="http://search.cpan.org/~btrott/"
SRC_URI="mirror://cpan/authors/id/B/BT/BTROTT/${MY_P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ~mips ~ppc ppc64 sparc x86"
IUSE=""

DEPEND="dev-lang/perl"
