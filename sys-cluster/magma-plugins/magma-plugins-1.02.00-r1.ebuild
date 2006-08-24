# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/magma-plugins/magma-plugins-1.02.00-r1.ebuild,v 1.2 2006/08/24 18:55:42 xmerlin Exp $

inherit eutils

CVS_RELEASE="20060713"
MY_P="cluster-${PV}"

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

DEPEND=">=sys-cluster/magma-1.02.00-r1
	>=sys-cluster/dlm-1.02.00-r1
	>=sys-cluster/cman-1.02.00-r1
	"

#	!nogulm? ( >=sys-cluster/gulm-1.02.00-r1 )"


S="${WORKDIR}/${MY_P}/${PN}"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${WORKDIR}/${PN}-${PV}-${CVS_RELEASE}-cvs.patch || die
}

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
