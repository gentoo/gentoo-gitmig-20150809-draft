# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/gulm/gulm-1.0_pre25.ebuild,v 1.2 2005/03/19 21:39:56 xmerlin Exp $

inherit linux-mod

MY_PV="${PV/_/-}"
MY_P="${PN}-${MY_PV}"

DESCRIPTION="Redundant server-based cluster and lock manager for GFS"
HOMEPAGE="http://sources.redhat.com/cluster/"
#SRC_URI="http://people.redhat.com/cfeist/cluster/tgz/${MY_P}.tar.gz"

SRC_URI="mirror://gentoo/${MY_P}.tar.gz
	http://dev.gentoo.org/~xmerlin/gfs/${MY_P}.tar.gz"

IUSE=""

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86"


DEPEND=">=sys-cluster/ccs-0.24
	>=sys-cluster/cman-1.0_pre31
	sys-apps/tcp-wrappers
	"

RDEPEND="sys-apps/tcp-wrappers"


S="${WORKDIR}/${MY_P}"

src_compile() {
	./configure --kernel_src=/usr/src/linux || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die

	rm -f ${D}/etc/init.d/lock_gulmd
}
