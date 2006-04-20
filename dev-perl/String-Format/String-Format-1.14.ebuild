# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/String-Format/String-Format-1.14.ebuild,v 1.1 2006/04/20 02:27:21 mcummings Exp $

inherit perl-module

DESCRIPTION="sprintf-like string formatting capabilities with arbitrary format definitions"
HOMEPAGE="http://search.cpan.org/search?query=${PN}"
SRC_URI="mirror://cpan/authors/id/D/DA/DARREN/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~x86 ~sparc"
IUSE=""

SRC_TEST="do"

