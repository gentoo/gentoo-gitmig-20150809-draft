# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/net-server/net-server-0.85.ebuild,v 1.1 2003/06/28 03:50:32 mcummings Exp $

inherit perl-module

MY_P=Net-Server-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Extensible, general Perl server engine"
SRC_URI="http://www.cpan.org/modules/by-authors/id/R/RH/RHANDOM/${MY_P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-authors/id/R/RH/RHANDOM/${MY_P}.readme"

SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="x86 ~alpha ~arm ~hppa ~mips ~ppc ~sparc"

mydoc="README"
