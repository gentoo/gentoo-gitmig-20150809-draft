# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/perl-Thread-Semaphore/perl-Thread-Semaphore-2.120.0.ebuild,v 1.1 2011/05/19 13:17:31 tove Exp $

DESCRIPTION="Virtual for ${PN#perl-}"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="|| ( ~dev-lang/perl-5.14.0 ~perl-core/${PN#perl-}-${PV} )"
