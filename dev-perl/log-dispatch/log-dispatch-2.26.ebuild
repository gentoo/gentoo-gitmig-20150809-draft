# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/log-dispatch/log-dispatch-2.26.ebuild,v 1.1 2009/09/23 19:13:57 tove Exp $

EAPI=2

MODULE_AUTHOR=DROLSKY
MY_PN=Log-Dispatch
MY_P=${MY_PN}-${PV}
S=${WORKDIR}/${MY_P}
inherit perl-module

DESCRIPTION="Dispatches messages to multiple Log::Dispatch::* objects"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND="dev-perl/Params-Validate
	>=virtual/perl-Sys-Syslog-0.16"
DEPEND="${RDEPEND}
	>=virtual/perl-Module-Build-0.28"

SRC_TEST="do"
