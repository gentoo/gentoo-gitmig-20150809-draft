# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Common/Common-1.0.4.ebuild,v 1.7 2003/06/01 19:41:06 mholzer Exp $

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
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"

DEPEND="dev-lang/ocaml
		dev-lang/perl"


src_compile() {
	cd ../../perl-MDK-Common;
	patch -p0 <${FILESDIR}/Common-1.0.4.patch || die
	cp Makefile Makefile.bak
   sed -e "s: /usr: ${D}/usr:" Makefile.bak > Makefile
   make \
              PREFIX=${D}/usr \
                INSTALLMAN1DIR=${D}/usr/share/man/man1 \
                INSTALLMAN2DIR=${D}/usr/share/man/man2 \
                INSTALLMAN3DIR=${D}/usr/share/man/man3 \
                INSTALLMAN4DIR=${D}/usr/share/man/man4 \
                INSTALLMAN5DIR=${D}/usr/share/man/man5 \
                INSTALLMAN6DIR=${D}/usr/share/man/man6 \
                INSTALLMAN7DIR=${D}/usr/share/man/man7 \
                INSTALLMAN8DIR=${D}/usr/share/man/man8 \
                INSTALLSITEMAN1DIR=${D}/usr/share/man/man1 \
                INSTALLSITEMAN2DIR=${D}/usr/share/man/man2 \
                INSTALLSITEMAN3DIR=${D}/usr/share/man/man3 \
                INSTALLSITEMAN4DIR=${D}/usr/share/man/man4 \
                INSTALLSITEMAN5DIR=${D}/usr/share/man/man5 \
                INSTALLSITEMAN6DIR=${D}/usr/share/man/man6 \
                INSTALLSITEMAN7DIR=${D}/usr/share/man/man7 \
                INSTALLSITEMAN8DIR=${D}/usr/share/man/man8 \
                INSTALLSITEARCH=${D}/${SITE_ARCH} \
                INSTALLSCRIPT=${D}/usr/bin 

}

src_install() {
	cd ../../perl-MDK-Common;
        make install

}
																																		
#src_prep() {
#	SRC_PREP="yes"
#	cd soft/perl-MDK-Common
#}



