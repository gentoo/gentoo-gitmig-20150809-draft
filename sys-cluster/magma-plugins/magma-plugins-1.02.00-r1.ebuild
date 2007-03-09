# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/magma-plugins/magma-plugins-1.02.00-r1.ebuild,v 1.5 2007/03/09 11:15:04 xmerlin Exp $

inherit eutils

CLUSTER_RELEASE="1.02.00"
MY_P="cluster-${CLUSTER_RELEASE}"
CVS_RELEASE="20060713"

DESCRIPTION="Magma cluster interface plugins"
HOMEPAGE="http://sources.redhat.com/cluster/"
SRC_URI="ftp://sources.redhat.com/pub/cluster/releases/${MY_P}.tar.gz
	mirror://gentoo/${PN}-${PV}-${CVS_RELEASE}-cvs.patch.gz
	http://dev.gentoo.org/~xmerlin/gfs/${PN}-${PV}-${CVS_RELEASE}-cvs.patch.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
#IUSE="nogulm"
IUSE=""

DEPEND="=sys-cluster/magma-${CLUSTER_RELEASE}*
	=sys-cluster/dlm-${CLUSTER_RELEASE}*
	=sys-cluster/cman-headers-${CLUSTER_RELEASE}*
	"

RDEPEND=""

#	!nogulm? ( >=sys-cluster/gulm-${CLUSTER_RELEASE}* )"


S="${WORKDIR}/${MY_P}/${PN}"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${WORKDIR}/${PN}-${PV}-${CVS_RELEASE}-cvs.patch || die
}

src_compile() {
	./configure || die "configure problem"

	for i in cman dumb sm; do
		emake -C ${i} all || die "compile problem"
	done
#	use nogulm || emake -C gulm all
}

src_install() {
	for i in cman dumb sm; do
		emake -C ${i} DESTDIR=${D} install || die "install problem"
	done
#	use nogulm || make -C gulm DESTDIR=${D} install || die
}
