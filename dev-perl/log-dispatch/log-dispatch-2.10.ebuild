# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/log-dispatch/log-dispatch-2.10.ebuild,v 1.9 2005/08/26 01:13:19 agriffis Exp $

inherit perl-module

MY_P=Log-Dispatch-${PV}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Dispatches messages to multiple Log::Dispatch::* objects"
SRC_URI="mirror://cpan/authors/id/D/DR/DROLSKY/${MY_P}.tar.gz"
HOMEPAGE="http://www.cpan.org/authors/id/D/DR/DROLSKY/"
SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="alpha ~amd64 ~ia64 ~ppc sparc x86"
IUSE=""

SRC_TEST="do"

DEPEND="${DEPEND}
		dev-perl/module-build
		dev-perl/Params-Validate"
