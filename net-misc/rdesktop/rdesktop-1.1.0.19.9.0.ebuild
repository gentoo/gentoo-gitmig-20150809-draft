# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-misc/rdesktop/rdesktop-1.1.0.19.9.0.ebuild,v 1.3 2002/12/09 04:33:18 manson Exp $

PATCH_PV="19-9-0"
PATCH_PV_SED=".${PATCH_PV//-/.}"
MY_P=${P/$PATCH_PV_SED}

S=${WORKDIR}/${MY_P}
DESCRIPTION="A Remote Desktop Protocol Client"
SRC_URI="mirror://sourceforge/rdesktop/${MY_P}.tar.gz
        http://bibl4.oru.se/projects/rdesktop/rdesktop-unified-patch${PATCH_PV}.bz2"
HOMEPAGE="http://rdesktop.sourceforge.net/"

KEYWORDS="x86 ~ppc ~sparc "
DEPEND="x11-base/xfree
        ssl? ( >=dev-libs/openssl-0.9.6b )"
LICENSE="GPL-2"
SLOT="0"

src_unpack() {
        unpack ${MY_P}.tar.gz
        cd ${S}
        bzcat ${DISTDIR}/rdesktop-unified-patch${PATCH_PV}.bz2 | patch -p2
}

src_compile() {
        local myconf
        use ssl && myconf="--with-openssl"
        use ssl || myconf="--without-openssl"
        [ "${DEBUG}" ] && myconf="${myconf} --with-debug"
        ./configure \
                --prefix=/usr \
                --mandir=/usr/share/man $myconf || die
        use ssl && echo "CFLAGS += -I/usr/include/openssl" >> Makeconf
        # Hold on tight folks, this ain't purdy
        if [ ! -z "${CXXFLAGS}" ]; then
                sed -e 's/-O2//g' Makefile > Makefile.tmp && mv Makefile.tmp Makefile
                echo "CFLAGS += ${CXXFLAGS}" >> Makeconf
        fi
	make localendian.h || die
        emake || die "compile problem"
}

src_install () {
        dobin rdesktop
        doman rdesktop.1
        dodoc COPYING CHANGES readme.txt rdp-srvr-readme.txt
}
