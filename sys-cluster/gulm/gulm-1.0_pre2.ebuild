# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/gulm/gulm-1.0_pre2.ebuild,v 1.1 2005/01/27 04:47:30 xmerlin Exp $

inherit eutils linux-mod

MY_PV="${PV/_/-}"
MY_P="${PN}-${MY_PV}"

DESCRIPTION="This is the gfs global locking manager"
HOMEPAGE="http://sources.redhat.com/cluster/"
SRC_URI="http://people.redhat.com/cfeist/cluster/tgz/${MY_P}.tar.gz"
IUSE=""

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86"


DEPEND="virtual/libc
	sys-cluster/ccs
	sys-cluster/cman
	tcpd? (sys-apps/tcp-wrappers)
	"

RDEPEND="virtual/libc
	tcpd? (sys-apps/tcp-wrappers)"


S="${WORKDIR}/${MY_P}"

src_compile() {
	./configure --kernel_src=/usr/src/linux || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
}
