# Copyright 2002 damien krotkine <dams@gentoo.org>
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/ldetect-lst/ldetect-lst-0.1.4.ebuild,v 1.1 2002/12/07 18:30:54 dams Exp $

ECVS_ANON="no"
ECVS_USER="anoncvs"
ECVS_SERVER="cvs.mandrakesoft.com:/cooker"
ECVS_MODULE="soft/ldetect-lst"
ECVS_PASS="cvs"
ECVS_CVS_OPTIONS="-dP"

inherit cvs

S=${WORKDIR}/${ECVS_MODULE}
DESCRIPTION="Hardware list for the light detection library."
HOMEPAGE="http://cvs.mandrakesoft.com/cgi-bin/cvsweb.cgi/soft/ldetect-lst/"
SRC_URI=""

SLOT="0"
LICENSE="GPL"
KEYWORDS="~x86 ~ppc ~sparc ~sparc64 ~alpha"

src_compile() {
	cd ../../ldetect-lst;
	echo " ------- pwd : $PWD"
        patch -p1 <${FILESDIR}/ldetect-lst-0.1.4.patch || die
	make prefix=${D}/usr clean;
	make
}

src_install() {
	cd ../../ldetect-lst;
	echo " ----------- install in ${PWD}"
	make prefix=${D}/usr install
}
