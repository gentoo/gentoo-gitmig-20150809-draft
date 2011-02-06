# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/eject/eject-0.ebuild,v 1.4 2011/02/06 11:57:25 leio Exp $

DESCRIPTION="Virtual for command eject"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86 ~sparc-fbsd ~x86-fbsd ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND="|| ( sys-apps/eject
	sys-block/unieject
	sys-block/eject-bsd )"
DEPEND="${RDEPEND}"
