# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Acme-Pr0n-Automate/Acme-Pr0n-Automate-0.05.ebuild,v 1.7 2004/07/14 16:30:17 agriffis Exp $

inherit perl-module

DESCRIPTION="Acme-Pr0n-Automate module for perl"
SRC_URI="http://cpan.org/modules/by-module/Acme/${P}.tar.gz"
HOMEPAGE="http://cpan.org/modules/by-module/Acme/"

SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="x86 amd64 ppc sparc alpha"
IUSE=""

DEPEND="${DEPEND}"

export OPTIMIZE="$CFLAGS"
