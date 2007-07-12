# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/input-utils/input-utils-0.0.1_pre20050727.ebuild,v 1.2 2007/07/12 05:10:21 mr_bones_ Exp $

MY_P=input-${PV/0.0.1_pre/}-141704

DESCRIPTION="Small collection of linux input layer utils"
HOMEPAGE="http://dl.bytesex.org/cvs-snapshots/"
SRC_URI="http://dl.bytesex.org/cvs-snapshots/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=""
RDEPEND=""

S="${WORKDIR}/input"

src_install() {
	make install bindir=${D}/usr/bin mandir=${D}/usr/share/man || die "make	install failed"

	dodoc lircd.conf
}
