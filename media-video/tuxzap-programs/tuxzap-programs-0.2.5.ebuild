# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/tuxzap-programs/tuxzap-programs-0.2.5.ebuild,v 1.1 2003/06/18 12:48:29 seemant Exp $

IUSE="gtk"

MY_P=${PN/-/_}-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="mpegtools package for manipulation of various MPEG file formats"
HOMEPAGE="http://www.metzlerbros.org/dvb/"
SRC_URI="http://www.metzlerbros.org/dvb/${MY_P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

DEPEND=">=sys-apps/sed-4
	>=media-tv/linuxtv-dvb-1.0.0_pre2
	>=media-libs/libdvb-0.2.1
	dev-libs/cdk
	gtk? ( =x11-libs/gtk+-1.2* )"


src_compile() {
    myconf='--with-dvb-path=/usr/lib'
    # not using X use var because gtk is needed too anyway
    use gtk || myconf=${myconf}' --without-x'
    econf ${myconf} || die

    # still assumes to be in the DVB dir 
    sed -i \
		-e s%../../../libdvb%/usr/include/libdvb%g  \
		-e s%../../../include%/usr/include%g \
		${S}/src/Makefile

    emake || die 'compile failed'
}

src_install() {
    make DESTDIR=${D} install || die
    
    dodoc ${S}/README ${S}/AUTHORS ${S}/NEWS ${S}/ChangeLog
}
