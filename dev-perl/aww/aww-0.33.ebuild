# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/aww/aww-0.33.ebuild,v 1.1 2004/07/28 12:01:33 mcummings Exp $


inherit perl-module

IUSE=""

MY_P=${P/a/A}
S=${WORKDIR}/${MY_P}
CATEGORY="dev-perl"

DESCRIPTION="Aww is a command-line frontend to the website meta language (wml)"
HOMEPAGE="http://www.panhorst.com/aww/"
SRC_URI="mirror://sourceforge/aww/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"


DEPEND="dev-lang/perl
dev-perl/HTML-Parser
dev-perl/Crypt-Blowfish
dev-perl/Getopt-Long
dev-perl/Data-Dumper
dev-perl/crypt-cbc
dev-perl/Config-Simple"


RDEPEND="net-ftp/lftp
>=dev-lang/wml-2.0.9
dev-perl/HTML-Parser
dev-perl/Crypt-Blowfish
dev-perl/Getopt-Long
dev-perl/Data-Dumper"
