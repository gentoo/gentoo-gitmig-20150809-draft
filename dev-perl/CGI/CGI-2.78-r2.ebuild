# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-perl/CGI/CGI-2.78-r2.ebuild,v 1.7 2002/09/21 01:04:55 vapier Exp $

inherit perl-module

MY_P=${PN}.pm-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="The Perl CGI Module"
SRC_URI="http://www.cpan.org/authors/id/LDS/${MY_P}.tar.gz"
HOMEPAGE="http://search.cpan.org/author/LDS/CGI.pm-${PV}/"

SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="x86 ppc sparc sparc64"
