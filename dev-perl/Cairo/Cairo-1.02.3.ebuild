# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Cairo/Cairo-1.02.3.ebuild,v 1.2 2007/03/28 13:23:18 armin76 Exp $

inherit perl-module versionator

MY_P="${PN}-$(delete_version_separator 2)"
S=${WORKDIR}/${MY_P}

DESCRIPTION="Perl interface to the cairo library"
HOMEPAGE="http://search.cpan.org/~tsch"
SRC_URI="mirror://cpan/authors/id/T/TS/TSCH/${MY_P}.tar.gz"

IUSE=""
SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"

SRC_TEST="do"

DEPEND=">=x11-libs/cairo-1.0.0
	>=dev-perl/extutils-depends-0.205
	>=dev-perl/extutils-pkgconfig-1.07"
