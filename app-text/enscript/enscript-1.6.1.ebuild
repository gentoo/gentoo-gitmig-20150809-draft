# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Dan Armak <danarmak@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-text/enscript/enscript-1.6.1.ebuild,v 1.1 2001/07/23 18:40:38 danarmak Exp $

S=${WORKDIR}/${P}
SRC_URI="ftp://ftp.gnu.org/gnu/enscript/${P}.tar.gz"

HOMEPAGE="http:/www.gnu.org/software/enscript/enscript.html"
DESCRIPTION="GNU's enscript is a powerful text-to-postsript converter"

DEPEND="sys-devel/flex sys-devel/bison"

src_compile() {
    
    confopts="--infodir=/usr/share/info --mandir=/usr/share/man --prefix=/usr --host=${CHOST}"
    
    try ./configure ${confopts}
    
    try emake

}

src_install () {

    try make DESTDIR=${D} install
    
    # I have no idea why, but the default config file isn't getting
    # installed. Sometime I'll research that.
    insinto /etc
    doins ${S}/lib/enscript.cfg

}

pkg_postinst() {

    echo "
    Now, customize /etc/enscript.cfg.
    "
    
}