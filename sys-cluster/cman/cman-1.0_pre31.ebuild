# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/cman/cman-1.0_pre31.ebuild,v 1.3 2005/03/23 02:37:10 xmerlin Exp $

MY_PV="${PV/_/-}"
MY_P="${PN}-${MY_PV}"

DESCRIPTION="general-purpose symmetric cluster manager"
HOMEPAGE="http://sources.redhat.com/cluster/"
#SRC_URI="http://people.redhat.com/cfeist/cluster/tgz/${MY_P}.tar.gz"

SRC_URI="mirror://gentoo/${MY_P}.tar.gz
	http://dev.gentoo.org/~xmerlin/gfs/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=sys-cluster/ccs-0.24
	>=sys-cluster/cman-kernel-2.6.9"

RDEPEND="virtual/libc"


S="${WORKDIR}/${MY_P}"

src_compile() {
	./configure || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die

	exeinto /etc/init.d ; newexe ${FILESDIR}/cman.rc cman || die
	insinto /etc/conf.d ; newins ${FILESDIR}/cman.conf cman || die
}
