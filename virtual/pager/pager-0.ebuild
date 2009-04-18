# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/pager/pager-0.ebuild,v 1.2 2009/04/18 19:44:46 ulm Exp $

DESCRIPTION="Virtual for command-line pagers"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc ~sparc-fbsd x86 ~x86-fbsd"
IUSE=""

DEPEND=""
RDEPEND="|| ( sys-apps/less
	sys-apps/more
	sys-apps/most
	sys-apps/util-linux
	app-text/lv )"
