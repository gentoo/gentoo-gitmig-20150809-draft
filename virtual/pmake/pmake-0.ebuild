# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/pmake/pmake-0.ebuild,v 1.5 2008/01/02 12:43:20 grobian Exp $

DESCRIPTION="Virtual for BSD-like make"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI=""

LICENSE="BSD"
SLOT="0"
KEYWORDS="alpha amd64 arm ia64 ~mips ppc sparc ~sparc-fbsd x86 ~x86-fbsd"
IUSE=""

RDEPEND="!userland_BSD? ( sys-devel/pmake )"
