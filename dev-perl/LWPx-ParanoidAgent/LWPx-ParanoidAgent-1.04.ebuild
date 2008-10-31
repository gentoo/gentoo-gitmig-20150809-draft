# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/LWPx-ParanoidAgent/LWPx-ParanoidAgent-1.04.ebuild,v 1.1 2008/10/31 17:18:25 tove Exp $

MODULE_AUTHOR=BRADFITZ
inherit perl-module

DESCRIPTION="Subclass of LWP::UserAgent that protects you from harm"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-perl/libwww-perl
	dev-perl/Net-DNS
	virtual/perl-Time-HiRes"

SRC_TEST=no
