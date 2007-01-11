# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Cairo/Cairo-1.02.1.ebuild,v 1.3 2007/01/11 14:27:19 gustavoz Exp $

inherit perl-module versionator

MY_P="${PN}-$(delete_version_separator 2)"
S=${WORKDIR}/${MY_P}

DESCRIPTION="Perl interface to the cairo library"
HOMEPAGE="http://search.cpan.org/search?query=${PN}"
SRC_URI="mirror://cpan/authors/id/T/TS/TSCH/${MY_P}.tar.gz"

IUSE=""
SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="amd64 ~hppa ~ppc ~ppc64 sparc ~x86"

SRC_TEST="do"

DEPEND="x11-libs/cairo
	>=dev-perl/extutils-depends-0.205
	>=dev-perl/extutils-pkgconfig-1.07"
