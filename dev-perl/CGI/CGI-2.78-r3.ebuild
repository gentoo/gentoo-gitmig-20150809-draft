# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/CGI/CGI-2.78-r3.ebuild,v 1.6 2003/03/26 21:41:40 rac Exp $

inherit perl-module

MY_P=${PN}.pm-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="The Perl CGI Module"
SRC_URI="http://www.cpan.org/authors/id/LDS/${MY_P}.tar.gz"
HOMEPAGE="http://search.cpan.org/author/LDS/CGI.pm-${PV}/"

SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="x86 ppc sparc alpha"
# this is hairy because 5.8.0 is in stable
# <rac@gentoo.org> 26 Mar 2003
#DEPEND="=dev-lang/perl-5.6.1* >=dev-perl/ExtUtils-MakeMaker-6.05-r1"
