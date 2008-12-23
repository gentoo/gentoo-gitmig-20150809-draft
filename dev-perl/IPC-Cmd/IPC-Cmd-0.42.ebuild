# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/IPC-Cmd/IPC-Cmd-0.42.ebuild,v 1.1 2008/12/23 08:45:16 robbat2 Exp $

MODULE_AUTHOR="KANE"

inherit perl-module

DESCRIPTION="finding and running system commands made easy"

IUSE=""

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ~x86"

DEPEND="virtual/perl-Locale-Maketext-Simple
	dev-perl/Module-Load-Conditional
	>=dev-perl/Params-Check-0.26"
