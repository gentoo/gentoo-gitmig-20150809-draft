# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/magma-plugins/magma-plugins-1.00.00.ebuild,v 1.1 2005/06/30 13:40:54 xmerlin Exp $


CLUSTER_VERSION="1.00.00"
DESCRIPTION="Magma cluster interface plugins"
HOMEPAGE="http://sources.redhat.com/cluster/"
SRC_URI="ftp://sources.redhat.com/pub/cluster/releases/cluster-${CLUSTER_VERSION}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86"
#IUSE="nogulm"
IUSE=""

DEPEND=">=sys-cluster/dlm-1.00.00
	>=sys-cluster/cman-1.00.00
	"

#	!nogulm? ( >=sys-cluster/gulm-1.00.00 )"


S="${WORKDIR}/cluster-${CLUSTER_VERSION}/${PN}"

src_compile() {
	./configure || die

	for i in cman dumb sm; do
		emake -C ${i} all
	done
#	use nogulm || emake -C gulm all
}

src_install() {
	for i in cman dumb sm; do
		make -C ${i} DESTDIR=${D} install || die
	done
#	use nogulm || make -C gulm DESTDIR=${D} install || die
}
