# Copyright 2002 damien krotkine <dams@gentoo.org>
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/ldetect-lst/ldetect-lst-0.1.4.ebuild,v 1.7 2003/06/22 05:10:31 seemant Exp $

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
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"

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
	cd ${D}/usr/share/ldetect-lst/
	ln -s pcitable.d/90default.lst ./pcitable
	ln -s usbtable.d/90default.lst ./usbtable
	ln -s pcmciatable.d/90default.lst ./pcmciatable
	ln -s isatable.d/90default.lst ./isatable
}
