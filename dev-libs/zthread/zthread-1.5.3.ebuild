# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $ Header: $

S=${WORKDIR}/ZThread-${PV}

DESCRIPTION="A Platform-Independent Object-Oriented Threading Architecture"
SRC_URI="mirror://sourceforge/zthread/ZThread-${PV}.tar.gz"
HOMEPAGE="http://www.cs.buffalo.edu/~crahen/projects/zthread/"

DEPEND=">=sys-libs/glibc-2.2.4"

src_compile() {
        local myconf
        if [ "${DEBUG}" ]
        then
                myconf="--enable-debug=yes"
        else
                myconf="--enable-debug=no"
        fi

        ./configure \
                --host=${CHOST} \
                --prefix=/usr \
                --infodir=/usr/share/info \
                --mandir=/usr/share/man || \
                ${myconf} || die "./configure failed"

        emake || die
}

src_install () {

        make prefix=${D}/usr install || die
        dodoc AUTHORS ChangeLog COPYING README* INSTALL NEWS TODO THANK.YOU
		
}

