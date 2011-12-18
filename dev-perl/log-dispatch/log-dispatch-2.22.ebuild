# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/log-dispatch/log-dispatch-2.22.ebuild,v 1.8 2011/12/18 16:13:24 armin76 Exp $

MODULE_AUTHOR=DROLSKY
MY_PN=Log-Dispatch
MY_P=${MY_PN}-${PV}
S=${WORKDIR}/${MY_P}
inherit perl-module

DESCRIPTION="Dispatches messages to multiple Log::Dispatch::* objects"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

SRC_TEST="do"

RDEPEND="dev-perl/Params-Validate
	virtual/perl-Sys-Syslog
	dev-lang/perl"
DEPEND="${RDEPEND}
	>=virtual/perl-Module-Build-0.28"
