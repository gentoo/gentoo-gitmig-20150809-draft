# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/sarg/sarg-1.2.2.ebuild,v 1.1 2002/11/14 10:11:26 jhhudso Exp $

DESCRIPTION="Sarg (Squid Analysis Report Generator) is a tool that allows you to view where your users are going to on the Internet."
HOMEPAGE="http://web.onda.com.br/orso/sarg.html"
SRC_URI="http://web.onda.com.br/orso/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND=""
#RDEPEND=">=net-www/squid-2.4.7"
S="${WORKDIR}/${P}"

src_compile() {
        rm -rf config.cache
        ./configure \
                --enable-bindir=/usr/bin \
                --enable-sysconfdir=/etc/sarg || die "./configure failed"
        emake || die
}

src_install () {
        mkdir ${D}/etc
        mkdir ${D}/etc/sarg
        mkdir ${D}/usr
        mkdir ${D}/usr/bin
        make \
                BINDIR=${D}/usr/bin \
                SYSCONFDIR=${D}/etc/sarg \
                install || die
}

