# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/dlm/dlm-1.0_pre21.ebuild,v 1.3 2005/03/23 02:39:25 xmerlin Exp $

MY_PV="${PV/_/-}"
MY_P="${PN}-${MY_PV}"

DESCRIPTION="General-purpose distributed lock manager"
HOMEPAGE="http://sources.redhat.com/cluster/"
#SRC_URI="http://people.redhat.com/cfeist/cluster/tgz/${MY_P}.tar.gz"

SRC_URI="mirror://gentoo/${MY_P}.tar.gz
	http://dev.gentoo.org/~xmerlin/gfs/${MY_P}.tar.gz"

IUSE=""

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~x86"


DEPEND=">=sys-cluster/dlm-kernel-2.6.9-r1"


S="${WORKDIR}/${MY_P}"

src_compile() {
	./configure || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die

	exeinto /etc/init.d ; newexe ${FILESDIR}/dlm.rc dlm || die

	dodoc doc/*.txt
}
