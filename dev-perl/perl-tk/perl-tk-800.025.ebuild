# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/perl-tk/perl-tk-800.025.ebuild,v 1.6 2004/07/14 20:10:30 agriffis Exp $

inherit perl-module

MY_P=Tk${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="A Perl Module for Tk"
SRC_URI="http://cpan.org/modules/by-authors/id/NI-S/${MY_P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-authors/Nick_Ing-Simmons/${MY_P}.readme"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 amd64 ~ppc sparc ~alpha ~hppa"
IUSE=""

DEPEND="${DEPEND}
	virtual/x11"

mydoc="COPYING ToDo VERSIONS"
