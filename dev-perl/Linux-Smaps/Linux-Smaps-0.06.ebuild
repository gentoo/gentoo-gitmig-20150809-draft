# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Linux-Smaps/Linux-Smaps-0.06.ebuild,v 1.4 2011/03/25 17:00:51 idl0r Exp $

EAPI="3"

MODULE_AUTHOR="OPI"

inherit perl-module linux-info

DESCRIPTION="Linux::Smaps - a Perl interface to /proc/PID/smaps"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-lang/perl
		dev-perl/Class-Member"
RDEPEND="${DEPEND}"

CONFIG_CHECK="~MMU ~PROC_PAGE_MONITOR"
