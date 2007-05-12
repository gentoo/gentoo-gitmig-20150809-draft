# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/dlm/dlm-1.03.00.ebuild,v 1.4 2007/05/12 13:15:34 xmerlin Exp $

CLUSTER_RELEASE="1.03.00"
MY_P="cluster-${CLUSTER_RELEASE}"

DESCRIPTION="General-purpose Distributed Lock Manager"
HOMEPAGE="http://sources.redhat.com/cluster/"
SRC_URI="ftp://sources.redhat.com/pub/cluster/releases/${MY_P}.tar.gz"

IUSE=""

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 x86"

DEPEND="=sys-cluster/dlm-headers-${CLUSTER_RELEASE}*"
RDEPEND=""

S="${WORKDIR}/${MY_P}/${PN}"

src_compile() {
	./configure || die "configure problem"
	emake || die "compile problem"
}

src_install() {
	emake DESTDIR=${D} install || die "install problem"
	rm -f ${D}/usr/include/libdlm.h

	newinitd ${FILESDIR}/${PN}.rc ${PN} || die
	dodoc doc/*.txt
}
