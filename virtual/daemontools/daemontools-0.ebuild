# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/daemontools/daemontools-0.ebuild,v 1.2 2011/01/29 23:34:44 bangert Exp $

DESCRIPTION="Virtual for daemontools"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86"

IUSE=""
DEPEND=""

RDEPEND="|| (
	sys-process/daemontools
	sys-process/daemontools-encore
)"
