# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/dlm/dlm-1.0_pre6.ebuild,v 1.1 2005/01/27 04:39:09 xmerlin Exp $

inherit eutils linux-mod

MY_PV="${PV/_/-}"
MY_P="${PN}-${MY_PV}"

DESCRIPTION="General-purpose distributed lock manager"
HOMEPAGE="http://sources.redhat.com/cluster/"
SRC_URI="http://people.redhat.com/cfeist/cluster/tgz/${MY_P}.tar.gz"

IUSE=""

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~x86"


DEPEND="sys-cluster/dlm-kernel"


S="${WORKDIR}/${MY_P}"

src_compile() {
	./configure --kernel_src=/usr/src/linux || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die

	dodoc doc/*.txt
}
