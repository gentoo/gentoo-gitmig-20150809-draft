# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/HTML-FromText/HTML-FromText-2.50.0.ebuild,v 1.1 2011/08/30 14:10:05 tove Exp $

EAPI=4

MODULE_AUTHOR=CWEST
MODULE_VERSION=2.05
inherit perl-module

DESCRIPTION="Convert plain text to HTML"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~sparc ~x86"
IUSE=""

DEPEND="dev-perl/HTML-Parser
	virtual/perl-Test-Simple
	dev-perl/Exporter-Lite
	>=virtual/perl-Scalar-List-Utils-1.14
	dev-perl/Email-Find"
RDEPEND="${DEPEND}"

#SRC_TEST="do"
