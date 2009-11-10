# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Convert-BER/Convert-BER-1.3200.ebuild,v 1.1 2009/11/10 10:00:03 robbat2 Exp $

MY_PV="${PV/00}"
MY_P="${PN}-${MY_PV}"
MODULE_AUTHOR=GBARR
inherit perl-module

DESCRIPTION="Class for encoding/decoding BER messages"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE=""
DEPEND="dev-lang/perl"
