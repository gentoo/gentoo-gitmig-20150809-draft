# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libcapsinetwork/libcapsinetwork-0.2.3.ebuild,v 1.2 2003/02/13 14:18:26 vapier Exp $
inherit flag-o-matic

IUSE=""
DESCRIPTION="libCapsiNetwork is a C++ network library to allow fast development of server daemon processes."
HOMEPAGE="http://sourceforge.net/projects/libcapsinetwork/"
SRC_URI="mirror://sourceforge/libcapsinetwork/${P}.tar.bz2"
LICENSE="LGPL-2.1"
SLOT="1"
KEYWORDS="x86 sparc "

DEPEND=""

filter-flags "-fomit-frame-pointer"

src_install () {
	einstall
}
