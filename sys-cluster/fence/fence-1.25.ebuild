# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/fence/fence-1.25.ebuild,v 1.4 2005/03/23 02:41:47 xmerlin Exp $

DESCRIPTION="I/O fencing system"
HOMEPAGE="http://sources.redhat.com/cluster/"
#SRC_URI="http://people.redhat.com/cfeist/cluster/tgz/${P}.tar.gz"

SRC_URI="mirror://gentoo/${P}.tar.gz
	http://dev.gentoo.org/~xmerlin/gfs/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=sys-cluster/ccs-0.24
	>=sys-cluster/cman-kernel-2.6.9"


src_compile() {
	./configure || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die

	exeinto /etc/init.d ; newexe ${FILESDIR}/fenced.rc fenced || die
	insinto /etc/conf.d ; newins ${FILESDIR}/fenced.conf fenced || die
}
