# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/pbnj/pbnj-2.04.ebuild,v 1.1 2006/11/16 17:17:20 jokey Exp $

inherit perl-module

DESCRIPTION="A tool for running Nmap scans and diff'ing the results"
HOMEPAGE="http://pbnj.sourceforge.net/"
SRC_URI="mirror://sourceforge/pbnj/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="net-analyzer/nmap
	dev-lang/perl
	dev-perl/Text-Diff
	dev-perl/List-MoreUtils
	dev-perl/yaml
	dev-perl/DBI
	dev-perl/DBD-SQLite
	dev-perl/XML-Twig
	dev-perl/File-Which
	dev-perl/File-HomeDir
	dev-perl/Text-CSV_XS
	dev-perl/Nmap-Parser"
RDEPEND="${DEPEND}"
