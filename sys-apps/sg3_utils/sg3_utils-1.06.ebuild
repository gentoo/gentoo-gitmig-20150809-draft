# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/sg3_utils/sg3_utils-1.06.ebuild,v 1.1 2004/02/10 22:33:46 plasmaroo Exp $

DESCRIPTION="Sg3_utils provide a collection of programs that use the sg SCSI interface"
HOMEPAGE="http://www.torque.net/sg/"
SRC_URI="http://www.torque.net/sg/p/sg3_utils-1.06.tgz"

LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~x86"
IUSE=""

DEPEND=""

src_compile() {
	emake || die
}

src_install() {
	einstall INSTDIR=${D}/usr/bin MANDIR=${D}/usr/man || die
}
