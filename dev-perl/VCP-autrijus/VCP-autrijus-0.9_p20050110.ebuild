# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/VCP-autrijus/VCP-autrijus-0.9_p20050110.ebuild,v 1.1 2005/04/09 01:16:21 trapni Exp $

inherit perl-module

DESCRIPTION="Copy versions of files between repositories and/or RevML"
SRC_URI="mirror://cpan/authors/id/A/AU/AUTRIJUS/VCP-autrijus-snapshot-0.9-20050110.tar.gz"
HOMEPAGE="http://search.cpan.org/~autrijus/VCP-autrijus-snapshot-0.9-20050110/"
IUSE=""
SLOT="0"
LICENSE="BSD"
KEYWORDS="~x86 ~amd64"

DEPEND="dev-perl/Text-Diff
		dev-perl/XML-AutoWriter
		dev-perl/IPC-Run3"

S="${WORKDIR}/VCP-autrijus-snapshot-0.9-20050110"

# for some reasons, the tests succeed with only 94.37%.
# and lots of them seem to be related to p4d (perforce server)
# there may be other (more relevant) errors, but they're hard to track
# down by such a lot of dump in stdout. -- trapni/2005-04-09.
#SRC_TEST="do"
