# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-misc/wget/wget-1.7-r2.ebuild,v 1.2 2001/11/24 18:40:50 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Network utility to retrieve files from the WWW"
SRC_URI="ftp://prep.ai.mit.edu/gnu/wget/${P}.tar.gz
         http://www.biscom.net/~cade/away/wget-new-percentage/wget-new-percentage-1.7-20010606.diff"
HOMEPAGE="http://www.cg.tuwien.ac.at/~prikryl/wget.html"

DEPEND="virtual/glibc 
        nls? ( sys-devel/gettext )
        ssl? ( >=dev-libs/openssl-0.9.6b )"

RDEPEND="virtual/glibc"

src_unpack() {
    unpack ${P}.tar.gz
    cd ${S}/src
    patch -p0 < ${DISTDIR}/wget-new-percentage-1.7-20010606.diff
}

src_compile() {
    local myconf
    use nls || myconf="--disable-nls"
    use ssl && myconf="$myconf --with-ssl"
    [ -z "$DEBUG" ] && myconf="$myconf --disable-debug"
    ./configure --prefix=/usr --sysconfdir=/etc/wget \
	--infodir=/usr/share/info --mandir=usr/share/man $myconf || die
    if use static; then
       make LDFLAGS="--static" || die
    else
       make || die
    fi
}

src_install() {   
    if use build || use bootcd; then
        insinto /usr
        dobin ${S}/src/wget	
        return
    fi                      
    make prefix=${D}/usr sysconfdir=${D}/etc/wget \
        mandir=${D}/usr/share/man infodir=${D}/usr/share/info install || die
    dodoc AUTHORS COPYING ChangeLog MACHINES MAILING-LIST NEWS README TODO 
    dodoc doc/sample.wgetrc
}
