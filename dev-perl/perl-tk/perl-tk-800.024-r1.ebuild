# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-perl/perl-tk/perl-tk-800.024-r1.ebuild,v 1.4 2002/07/25 04:13:27 seemant Exp $


inherit perl-module

MY_P=Tk-${PV}
S=${WORKDIR}/${MY_P/-/}
DESCRIPTION="A Perl Module for Tk"
SRC_URI="http://perl.com/CPAN/modules/by-authors/Nick_Ing-Simmons/${MY_P}.tar.gz"
SLOT="0"
HOMEPAGE="http://www.cpan.org/modules/by-authors/Nick_Ing-Simmons/${MY_P}.readme"

SLOT="0"
DEPEND="${DEPEND}
	virtual/x11"

mydoc="COPYING ToDo VERSIONS"
