# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/perl-tk/perl-tk-800.024-r2.ebuild,v 1.6 2003/09/10 01:42:11 rac Exp $

inherit perl-module

MY_P=Tk-${PV}
S=${WORKDIR}/${MY_P/-/}
DESCRIPTION="A Perl Module for Tk"
SRC_URI="http://perl.com/CPAN/modules/by-authors/Nick_Ing-Simmons/${MY_P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-authors/Nick_Ing-Simmons/${MY_P}.readme"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 amd64 ppc sparc alpha"

DEPEND="${DEPEND}
	!=dev-perl/ExtUtils-MakeMaker-6.15
	virtual/x11"

mydoc="COPYING ToDo VERSIONS"
