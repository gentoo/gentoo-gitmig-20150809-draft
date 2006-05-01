# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/module-info/module-info-0.20.ebuild,v 1.11 2006/05/01 20:48:37 mcummings Exp $

inherit perl-module

MY_P="Module-Info-${PV}"
S=${WORKDIR}/${MY_P}
DESCRIPTION="Information about Perl modules"
SRC_URI="http://www.cpan.org/modules/by-authors/id/M/MB/MBARBON/${MY_P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-authors/id/M/MB/MBARBON/${MY_P}.readme"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="x86 alpha ~hppa ~mips ~ppc sparc amd64"
IUSE=""
