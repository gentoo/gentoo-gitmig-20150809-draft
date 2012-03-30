# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/shadow/shadow-0.ebuild,v 1.3 2012/03/30 02:58:41 heroxbd Exp $

DESCRIPTION="Virtual for user account management utilities"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86 ~amd64-linux ~x86-linux"
IUSE=""

# >=shadow-4-1 is required because of bug #367633 (user.eclass needs it).
DEPEND=""
RDEPEND="|| ( >=sys-apps/shadow-4.1 sys-apps/hardened-shadow )"
