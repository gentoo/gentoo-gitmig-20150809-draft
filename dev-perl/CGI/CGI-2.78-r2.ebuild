# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: Tools Team <tools@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-perl/CGI/CGI-2.78-r2.ebuild,v 1.2 2002/05/21 18:14:07 danarmak Exp $

# Inherit the perl-module.eclass functions

inherit perl-module

MY_P=${PN}.pm-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="The Perl CGI Module"
SRC_URI="http://www.cpan.org/authors/id/LDS/${MY_P}.tar.gz"

LICENSE="Artistic | GPL-2"
SLOT="0"
