# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Sysadm-Install/Sysadm-Install-0.34.ebuild,v 1.1 2010/04/14 15:03:30 idl0r Exp $

EAPI="2"

MODULE_AUTHOR="MSCHILLI"

inherit perl-module

DESCRIPTION="Typical installation tasks for system administrators"

LICENSE="|| ( Artistic GPL-1 GPL-2 GPL-3 )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="hammer"

DEPEND="dev-perl/TermReadKey
	dev-perl/libwww-perl
	dev-perl/Log-Log4perl
	dev-lang/perl
	hammer? ( dev-perl/Expect )"

SRC_TEST="do"
