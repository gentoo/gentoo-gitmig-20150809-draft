# Copyright 2002 damien krotkine <dams@gentoo.org>
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Common/Common-1.0.4.ebuild,v 1.1 2002/12/01 12:00:07 dams Exp $

ECVS_ANON="no"
ECVS_USER="anoncvs"
ECVS_SERVER="cvs.mandrakesoft.com:/cooker"
ECVS_MODULE="soft/perl-MDK-Common"
ECVS_PASS="cvs"
ECVS_CVS_OPTIONS="-dP"

inherit perl-module
inherit cvs

S=${WORKDIR}/${ECVS_MODULE}
DESCRIPTION="Common usefull perl functions"
HOMEPAGE="http://cvs.mandrakesoft.com/cgi-bin/cvsweb.cgi/soft/perl-MDK-Common/"
SRC_URI=""

SLOT="0"
LICENSE="GPL"
KEYWORDS="~x86 ~ppc ~sparc ~sparc64 ~alpha"

#DEPEND="${DEPEND}
#        >=dev-lang/ocaml"

#This patch may or may not be backwards compatible with perl-5.6.1
#Add gaurd as necessary...

#src_unpack() {
#	echo " ***** pouet $PWD";
#	echo "filesdir : ${FILESDIR}"
#        #unpack ${A}
#	echo " pwd : $PWD"
#        patch -p0 <${FILESDIR}/Common-1.0.4.patch || die
#}

src_compile() {
	cd ../../perl-MDK-Common;
	echo " pwd : $PWD"
        patch -p1 <${FILESDIR}/Common-1.0.4.patch || die
	echo "compile in ${PWD}";
	make clean;
	make
	#perl-module_src_prep;
	#perl-module_src_compile;
}

src_install() {
	cd ../../perl-MDK-Common;
	echo "install in ${PWD}"
	make PREFIX=${D}/usr install
}

src_prep() {
	SRC_PREP="yes"
	cd ../../perl-MDK-Common
	echo "prep in ${PWD}";	
}


