# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libpipeline/libpipeline-1.2.1.ebuild,v 1.1 2012/03/23 07:45:47 radhermit Exp $

EAPI="4"

inherit autotools-utils

DESCRIPTION="a pipeline manipulation library"
HOMEPAGE="http://libpipeline.nongnu.org/"
SRC_URI="mirror://nongnu/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE="static-libs test"

DEPEND="dev-util/pkgconfig
	test? ( dev-libs/check )"
