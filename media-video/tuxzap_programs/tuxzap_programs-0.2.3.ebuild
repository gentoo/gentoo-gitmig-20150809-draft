# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/tuxzap_programs/tuxzap_programs-0.2.3.ebuild,v 1.4 2003/03/21 17:43:23 mholzer Exp $

DESCRIPTION="mpegtools package for manipulation of various MPEG file formats"
HOMEPAGE="http://www.metzlerbros.org/dvb/"
SRC_URI="mirror://gentoo/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="gtk"
DEPEND=">=media-video/linuxtv-dvb-1.0.0_pre2
	>=media-libs/libdvb-0.2.1
	>=dev-libs/cdk-4.9.10.20020809
	gtk? ( =x11-libs/gtk+-1.2* )"
#RDEPEND=""
S=${WORKDIR}/${P}

src_compile() {
    MYCONF='--with-dvb-path=/usr/lib'
    # not using X use var because gtk is needed too anyway
    use gtk || MYCONF=${MYCONF}' --without-x'
    econf ${MYCONF}
    # still assumes to be in the DVB dir 
    mv ${S}/src/Makefile ${S}/src/Makefile_orig
    sed -e s%../../../libdvb%/usr/include/libdvb%g  \
	-e s%../../../include%/usr/include%g \
	${S}/src/Makefile_orig > ${S}/src/Makefile
    emake || die 'compile failed'
}

src_install() {
    make DESTDIR=${D} install || die
    
    # docs
    dodoc ${S}/README ${S}/AUTHORS ${S}/NEWS ${S}/ChangeLog
}

