# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/MooseX-ClassAttribute/MooseX-ClassAttribute-0.08.ebuild,v 1.2 2009/07/03 06:26:39 tove Exp $

EAPI=2

MODULE_AUTHOR=DROLSKY
inherit perl-module

DESCRIPTION="Declare class attributes Moose-style"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-perl/Moose
	dev-perl/MooseX-AttributeHelpers"
DEPEND="${RDEPEND}
	virtual/perl-Module-Build"

SRC_TEST=do
