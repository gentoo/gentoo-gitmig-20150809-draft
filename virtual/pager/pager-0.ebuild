# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/pager/pager-0.ebuild,v 1.1 2008/03/21 11:16:02 opfer Exp $

DESCRIPTION="Virtual for command-line pagers"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc ~sparc-fbsd x86 ~x86-fbsd"
IUSE=""

DEPEND=""
RDEPEND="|| ( sys-apps/less
	sys-apps/more
	sys-apps/most
	app-text/lv )"
