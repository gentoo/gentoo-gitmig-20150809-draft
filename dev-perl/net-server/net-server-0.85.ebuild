# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/net-server/net-server-0.85.ebuild,v 1.4 2004/05/30 16:23:08 kloeri Exp $

inherit perl-module

MY_P=Net-Server-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Extensible, general Perl server engine"
HOMEPAGE="http://www.cpan.org/modules/by-authors/id/R/RH/RHANDOM/${MY_P}.readme"
SRC_URI="http://www.cpan.org/modules/by-authors/id/R/RH/RHANDOM/${MY_P}.tar.gz"

LICENSE="Artistic | GPL-2"
SLOT="0"
KEYWORDS="x86 alpha ~hppa ~mips ~ppc ~sparc ~amd64"

mydoc="README"
