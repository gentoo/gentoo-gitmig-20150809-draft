# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/mnet/mnet-0.6.2.383.ebuild,v 1.6 2004/08/02 18:45:59 squinky86 Exp $

IUSE="gtk"
S=${WORKDIR}/${PN}
DESCRIPTION="Mnet is a universal file space. It is formed by an emergent network of autonomous nodes which self-organize to make the network robust and efficient."
SRC_URI="mirror://sourceforge/${PN}/${P/m/M}-STABLE-src.tar.gz"
RESTRICT="nomirror"
HOMEPAGE="http://mnet.sourceforge.net/"

DEPEND="dev-lang/python"
RDEPEND="virtual/libc
	dev-lang/python
	gtk? ( dev-python/wxpython  )"
LICENSE="LGPL-2.1"
KEYWORDS="x86 ~ppc"
SLOT="0"

src_compile() {
	EXTSRCDIR="${WORKDIR}/extsrc/" MNETDIR="${S}" make build
}

src_install() {
	dodoc COPYING CREDITS ChangeLog overview.txt hackerdocs/*
	dobin Mnet.sh
	rm Mnet.sh COPYING CREDITS ChangeLog overview.txt hackerdocs/*
	dodir /usr/share/mnet
	cp -r ${S}/* ${D}/usr/share/mnet
	insinto /etc/env.d
	doins ${FILESDIR}/96mnet
}

pkg_postinst() {
	einfo "If this is the first time Mnet is merged, please run 'env-update'"
	einfo "and 'source /etc/profile', otherwise execute 'Mnet.sh'"
}
