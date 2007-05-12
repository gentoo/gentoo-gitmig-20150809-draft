# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/magma-plugins/magma-plugins-1.03.00.ebuild,v 1.5 2007/05/12 13:30:01 xmerlin Exp $

CLUSTER_RELEASE="1.03.00"
MY_P="cluster-${CLUSTER_RELEASE}"

DESCRIPTION="Magma cluster interface plugins"
HOMEPAGE="http://sources.redhat.com/cluster/"
SRC_URI="ftp://sources.redhat.com/pub/cluster/releases/${MY_P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
#IUSE="nogulm"
IUSE=""

DEPEND="=sys-cluster/magma-${CLUSTER_RELEASE}*
	=sys-cluster/dlm-${CLUSTER_RELEASE}*
	=sys-cluster/cman-headers-${CLUSTER_RELEASE}*
	"

#	!nogulm? ( >=sys-cluster/gulm-${CLUSTER_RELEASE}* )"


S="${WORKDIR}/${MY_P}/${PN}"

src_compile() {
	./configure || die "configure problem"

	for i in cman dumb sm; do
		emake -C ${i} all || die "compile problem"
	done
#	use nogulm || emake -C gulm all
}

src_install() {
	for i in cman dumb sm; do
		make -C ${i} DESTDIR=${D} install || die "install problem"
	done
#	use nogulm || make -C gulm DESTDIR=${D} install || die
}
