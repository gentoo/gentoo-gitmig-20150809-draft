# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/net-server/net-server-0.85.ebuild,v 1.15 2006/08/06 02:54:10 mcummings Exp $

inherit perl-module

MY_P=Net-Server-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Extensible, general Perl server engine"
HOMEPAGE="http://www.cpan.org/modules/by-authors/id/R/RH/RHANDOM/${MY_P}.readme"
SRC_URI="mirror://cpan/authors/id/R/RH/RHANDOM/${MY_P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="x86 alpha ~hppa ~mips ppc sparc amd64"
IUSE=""

mydoc="README"



DEPEND="dev-lang/perl"
RDEPEND="${DEPEND}"
