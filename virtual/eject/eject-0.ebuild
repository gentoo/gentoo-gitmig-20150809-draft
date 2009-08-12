# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/eject/eject-0.ebuild,v 1.1 2009/08/12 19:22:15 ssuominen Exp $

DESCRIPTION="Virtual for command eject"
HOMEPAGE="http://www.gentoo.org"
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k mips ppc ppc64 s390 sh sparc x86 ~sparc-fbsd ~x86-fbsd"
IUSE=""

RDEPEND="|| ( sys-apps/eject
	sys-block/unieject
	sys-block/eject-bsd )"
DEPEND="${RDEPEND}"
