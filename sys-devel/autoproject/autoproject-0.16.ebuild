# Copyright 2002 Dan Hopkins <drhop12@earthlink.net>
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/sys-devel/autoproject/autoproject-0.16.ebuild,v 1.3 2003/02/28 13:18:14 liquidx Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Used to start a programming project using autoconf, automake, and optionally a command line parser generator"
SRC_URI="http://www.ibiblio.org/pub/Linux/devel/${P}.tar.gz
	http://www.mv.com/ipusers/vanzandt/${P}.tar.gz"
HOMEPAGE="http://www.mv.com/ipusers/vanzandt/"
LICENSE="GPL-2"
KEYWORDS="~x86"
DEPEND="sys-devel/automake"
SLOT="0"
IUSE=""

src_install() {
	cd ${S}
	make prefix=${D}/usr \
		datadir=${D}/usr/share \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		install || die

	docinto ${PV}
	dodoc COPYING AUTHORS BUGS NEWS README TODO THANKS
	dodoc ChangeLog
}
