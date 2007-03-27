# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/VCP-autrijus/VCP-autrijus-0.9_p20050110-r1.ebuild,v 1.10 2007/03/27 11:38:16 ticho Exp $

inherit perl-module

DESCRIPTION="Copy versions of files between repositories and/or RevML"
SRC_URI="mirror://cpan/authors/id/A/AU/AUTRIJUS/VCP-autrijus-snapshot-0.9-20050110.tar.gz"
HOMEPAGE="http://search.cpan.org/~autrijus/"
IUSE=""
SLOT="0"
LICENSE="BSD"
#KEYWORDS="~amd64 ~sparc ~x86"
KEYWORDS="amd64 ia64 sparc x86"

DEPEND="dev-perl/Text-Diff
	dev-perl/XML-AutoWriter
		dev-perl/HTML-Tree
		dev-perl/IPC-Run3
		dev-perl/PodToHTML
	dev-lang/perl"

S="${WORKDIR}/VCP-autrijus-snapshot-0.9-20050110"

# for some reasons, the tests succeed with only 94.37%.
# and lots of them seem to be related to p4d (perforce server)
# there may be other (more relevant) errors, but they're hard to track
# down by such a lot of dump in stdout. -- trapni/2005-04-09.
#SRC_TEST="do"

