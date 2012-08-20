# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/gcap/gcap-0.1.1.ebuild,v 1.1 2012/08/20 15:08:29 hasufell Exp $

EAPI=4

inherit perl-module

DESCRIPTION="Command line tool for downloading Youtube closed captions"
HOMEPAGE="http://code.google.com/p/gcap/"
SRC_URI="http://gcap.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-perl/Getopt-ArgvFile
		dev-perl/XML-DOM
		virtual/perl-Getopt-Long"
DEPEND="virtual/perl-ExtUtils-MakeMaker"

SRC_TEST="do"
