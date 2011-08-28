# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Authen-Libwrap/Authen-Libwrap-0.22.ebuild,v 1.1 2011/08/28 12:51:25 hwoarang Exp $

EAPI=2

MODULE_AUTHOR=DMUEY
inherit perl-module

DESCRIPTION="A Perl access to the TCP Wrappers interface"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="sys-apps/tcp-wrappers
	virtual/perl-Module-Build"
DEPEND="${RDEPEND}
	test? ( dev-perl/Test-Exception
	dev-perl/Test-Pod )"

SRC_TEST="do"
