# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/pmake/pmake-0.ebuild,v 1.7 2009/12/15 23:02:31 abcd Exp $

DESCRIPTION="Virtual for BSD-like make"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI=""

LICENSE="BSD"
SLOT="0"
KEYWORDS="alpha amd64 arm ia64 ~mips ppc sparc x86 ~sparc-fbsd ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris ~x86-solaris"
IUSE=""

RDEPEND="kernel_linux? ( sys-devel/pmake )
	kernel_SunOS? ( sys-devel/pmake )
	kernel_Darwin? ( sys-devel/bsdmake )"
