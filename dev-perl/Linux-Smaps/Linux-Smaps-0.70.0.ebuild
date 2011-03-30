# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Linux-Smaps/Linux-Smaps-0.70.0.ebuild,v 1.1 2011/03/30 06:31:43 tove Exp $

EAPI=4

MODULE_AUTHOR=OPI
MODULE_VERSION=0.07
inherit perl-module linux-info

DESCRIPTION="Linux::Smaps - a Perl interface to /proc/PID/smaps"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

CONFIG_CHECK="~MMU ~PROC_PAGE_MONITOR"
