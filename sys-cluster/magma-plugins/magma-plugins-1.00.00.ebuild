# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/magma-plugins/magma-plugins-1.00.00.ebuild,v 1.5 2005/10/08 15:36:09 xmerlin Exp $

MY_P="cluster-${PV}"

DESCRIPTION="Magma cluster interface plugins"
HOMEPAGE="http://sources.redhat.com/cluster/"
SRC_URI="ftp://sources.redhat.com/pub/cluster/releases/${MY_P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
#IUSE="nogulm"
IUSE=""

DEPEND=">=sys-cluster/magma-1.00.00
	>=sys-cluster/dlm-1.00.00
	>=sys-cluster/cman-1.00.00
	"

#	!nogulm? ( >=sys-cluster/gulm-1.00.00 )"


S="${WORKDIR}/${MY_P}/${PN}"

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
