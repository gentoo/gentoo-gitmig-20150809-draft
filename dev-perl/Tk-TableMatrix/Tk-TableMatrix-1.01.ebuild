# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Tk-TableMatrix/Tk-TableMatrix-1.01.ebuild,v 1.2 2003/06/21 21:36:43 drobbins Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="Perl module for Tk-TableMatrix"
SRC_URI="http://search.cpan.org/CPAN/authors/id/C/CE/CERNEY/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/author/CERNEY/${P}"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 amd64 ppc sparc alpha"

DEPEND="dev-perl/perl-tk"
