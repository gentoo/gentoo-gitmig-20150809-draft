# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/sg3_utils/sg3_utils-1.06.ebuild,v 1.5 2004/08/09 21:38:41 plasmaroo Exp $

inherit eutils

DESCRIPTION="Sg3_utils provide a collection of programs that use the sg SCSI interface"
HOMEPAGE="http://www.torque.net/sg/"
SRC_URI="http://www.torque.net/sg/p/sg3_utils-1.06.tgz"

LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~x86 ~sparc ~amd64"
IUSE=""

DEPEND=""

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/${PN}-llseek.patch

	sed -i "s:-O2:$CFLAGS:g" Makefile
}

src_compile() {
	emake || die
}

src_install() {
	einstall INSTDIR=${D}/usr/bin MANDIR=${D}/usr/man || die
}
