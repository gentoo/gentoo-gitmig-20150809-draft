# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/File-Scan-ClamAV/File-Scan-ClamAV-1.91.ebuild,v 1.1 2009/05/17 08:44:19 dertobi123 Exp $

inherit perl-module

DESCRIPTION="Connect to a local Clam Anti-Virus clamd service and send commands"
HOMEPAGE="http://search.cpan.org/~JAMTUR/"
SRC_URI="mirror://cpan/authors/id/J/JA/JAMTUR/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86"
IUSE=""

DEPEND="app-antivirus/clamav"
RDEPEND="${DEPEND}"
