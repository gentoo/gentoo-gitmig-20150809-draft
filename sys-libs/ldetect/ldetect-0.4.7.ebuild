# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/ldetect/ldetect-0.4.7.ebuild,v 1.12 2004/08/24 04:19:03 swegener Exp $

ECVS_ANON="no"
ECVS_USER="anoncvs"
ECVS_SERVER="cvs.mandrakesoft.com:/cooker"
ECVS_MODULE="soft/ldetect"
ECVS_PASS="cvs"
ECVS_CVS_OPTIONS="-dP"

#inherit perl-module
inherit cvs

S=${WORKDIR}/${ECVS_MODULE}
DESCRIPTION="Light hardware detection library. The hardware device lists provided by this package are used as lookup table to get hardware autodetection"
HOMEPAGE="http://cvs.mandrakesoft.com/cgi-bin/cvsweb.cgi/soft/ldetect/"
SRC_URI=""

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc alpha"
IUSE=""

src_compile() {
	cd ../../ldetect;
	patch -p1 <${FILESDIR}/ldetect-0.4.7.patch || die
	make clean;
	make
}

src_install() {
	cd ../../ldetect;
	make prefix=${D}/usr install
}
