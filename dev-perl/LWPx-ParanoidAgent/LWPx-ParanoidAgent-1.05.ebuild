# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/LWPx-ParanoidAgent/LWPx-ParanoidAgent-1.05.ebuild,v 1.1 2009/06/22 20:08:34 tove Exp $

EAPI=2

MODULE_AUTHOR=BRADFITZ
inherit perl-module

DESCRIPTION="Subclass of LWP::UserAgent that protects you from harm"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-perl/libwww-perl
	dev-perl/Net-DNS
	virtual/perl-Time-HiRes"
RDEPEND="${DEPEND}"

SRC_TEST=no
