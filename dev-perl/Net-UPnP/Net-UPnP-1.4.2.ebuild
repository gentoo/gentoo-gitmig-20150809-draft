# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Net-UPnP/Net-UPnP-1.4.2.ebuild,v 1.4 2010/01/07 19:51:45 ranger Exp $

EAPI=2

MODULE_AUTHOR=SKONNO
inherit perl-module

DESCRIPTION="Perl extension for UPnP"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="virtual/perl-version"
DEPEND="${RDEPEND}"

SRC_TEST=do
