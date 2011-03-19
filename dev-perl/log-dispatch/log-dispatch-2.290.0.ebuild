# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/log-dispatch/log-dispatch-2.290.0.ebuild,v 1.1 2011/03/19 06:55:50 tove Exp $

EAPI=3

MY_PN=Log-Dispatch
MODULE_AUTHOR=DROLSKY
MODULE_VERSION=2.29
inherit perl-module

DESCRIPTION="Dispatches messages to multiple Log::Dispatch::* objects"

LICENSE="Artistic-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND="dev-perl/Params-Validate
	>=virtual/perl-Sys-Syslog-0.16"
DEPEND="${RDEPEND}
	>=virtual/perl-ExtUtils-MakeMaker-6.31"

SRC_TEST="do"
