# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Acme-Pr0n-Automate/Acme-Pr0n-Automate-0.05.ebuild,v 1.4 2003/02/13 10:55:20 vapier Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="Acme-Pr0n-Automate module for perl"
SRC_URI="http://cpan.org/modules/by-module/Acme/${P}.tar.gz"
HOMEPAGE="http://cpan.org/modules/by-module/Acme/"

SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="x86 ppc sparc alpha"

DEPEND="${DEPEND}"

export OPTIMIZE="$CFLAGS"
