# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Archive-Tar/Archive-Tar-0.22-r1.ebuild,v 1.1 2002/10/30 07:20:34 seemant Exp $

inherit perl-module

S=${WORKDIR}/${P}

DESCRIPTION="A Perl module for creation and manipulation of tar files"
SRC_URI="http://www.cpan.org/modules/by-module/Archive/SRZ/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/Archive/SRZ/${P}.readme"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 ppc sparc sparc64 alpha"
