# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/POE-Component-PreforkDispatch/POE-Component-PreforkDispatch-0.101.ebuild,v 1.2 2009/06/23 08:56:31 tove Exp $

EAPI=2

MODULE_AUTHOR="EWATERS"
inherit perl-module

DESCRIPTION="Preforking task dispatcher"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-perl/Error
	dev-perl/IO-Capture
	dev-perl/Params-Validate
	dev-perl/POE"
DEPEND="${RDEPEND}
	virtual/perl-Module-Build"
