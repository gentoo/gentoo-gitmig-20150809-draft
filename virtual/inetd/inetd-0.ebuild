# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/inetd/inetd-0.ebuild,v 1.1 2011/04/16 19:08:52 ulm Exp $

DESCRIPTION="Virtual for the internet super-server daemon"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86 ~sparc-fbsd ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~sparc-solaris"
IUSE=""

DEPEND=""
RDEPEND="|| ( sys-apps/xinetd
		sys-apps/netkit-base
		sys-apps/ucspi-tcp
		dev-python/twisted-runner
		net-misc/ipsvd
		sys-freebsd/freebsd-usbin )"
