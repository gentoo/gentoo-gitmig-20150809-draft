# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Lirc-Client/Lirc-Client-1.50.ebuild,v 1.1 2008/12/12 04:19:42 beandog Exp $

inherit perl-module

DESCRIPTION="A client library for the Linux Infrared Remote Control (LIRC)"
HOMEPAGE="http://search.cpan.org/search?query=Lirc-Client&mode=dist"
SRC_URI="mirror://cpan/authors/id/M/MG/MGRIMES/${P}.tar.gz"

IUSE=""

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64"

DEPEND="dev-perl/File-Path-Expand
	dev-perl/Class-Accessor
	dev-lang/perl"
