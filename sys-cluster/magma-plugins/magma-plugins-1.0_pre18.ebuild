# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/magma-plugins/magma-plugins-1.0_pre18.ebuild,v 1.2 2005/03/23 02:48:30 xmerlin Exp $

MY_PV="${PV/_/-}"
MY_P="${PN}-${MY_PV}"

DESCRIPTION="Magma cluster interface plugins"
HOMEPAGE="http://sources.redhat.com/cluster/"
SRC_URI="http://people.redhat.com/cfeist/cluster/tgz/${MY_P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86"
IUSE="nogulm"

DEPEND=">=sys-cluster/dlm-1.0_pre21
	>=sys-cluster/cman-1.0_pre31
	!nogulm? ( >=sys-cluster/gulm-1.0_pre25 )"

S="${WORKDIR}/${MY_P}"

src_compile() {
	./configure || die

	for i in cman dumb sm; do
		emake -C ${i} all
	done
	use nogulm || emake -C gulm all
}

src_install() {
	for i in cman dumb sm; do
		make -C ${i} DESTDIR=${D} install || die
	done
	use nogulm || make -C gulm DESTDIR=${D} install || die
}
