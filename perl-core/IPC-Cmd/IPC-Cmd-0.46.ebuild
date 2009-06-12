# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/IPC-Cmd/IPC-Cmd-0.46.ebuild,v 1.1 2009/06/12 20:15:15 tove Exp $

EAPI=2

MODULE_AUTHOR="KANE"
inherit perl-module

DESCRIPTION="finding and running system commands made easy"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="virtual/perl-Locale-Maketext-Simple
	virtual/perl-Module-Load-Conditional
	>=virtual/perl-Params-Check-0.26"
RDEPEND="${DEPEND}"

SRC_TEST=do
