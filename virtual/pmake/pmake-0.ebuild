# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/pmake/pmake-0.ebuild,v 1.2 2006/10/17 09:48:24 uberlord Exp $

DESCRIPTION="Virtual for BSD-like make"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI=""

LICENSE="BSD"
SLOT="0"
KEYWORDS="alpha amd64 arm ia64 ~mips ppc ~ppc-macos sparc ~sparc-fbsd x86 ~x86-fbsd"
IUSE=""

RDEPEND="|| ( sys-devel/pmake sys-freebsd/freebsd-ubin sys-openbsd/openbsd-ubin )"

