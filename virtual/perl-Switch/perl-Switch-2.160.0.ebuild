# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/perl-Switch/perl-Switch-2.160.0.ebuild,v 1.2 2012/10/29 02:49:36 blueness Exp $

DESCRIPTION="Virtual for ${PN#perl-}"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="|| ( =dev-lang/perl-5.12* ~perl-core/${PN#perl-}-${PV} )"
