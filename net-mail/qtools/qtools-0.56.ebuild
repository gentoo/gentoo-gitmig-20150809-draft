# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/qtools/qtools-0.56.ebuild,v 1.2 2003/05/14 03:00:45 robbat2 Exp $

inherit eutils

DESCRIPTION="Several utilities for use with qmail, typically as part of .qmail command processing"

HOMEPAGE="http://www.superscript.com/qtools/intro.html"

SRC_URI="http://www.superscript.com/qtools/${P}.tar.gz"

LICENSE="as-is"

SLOT="0"

KEYWORDS="x86 ~mips ~arm ~hppa ~alpha ~ppc ~sparc"

DEPEND="sys-devel/gcc-config"

S=${WORKDIR}/${P}

src_unpack() {
    unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-errno.patch
}

src_compile() {
    use static && LDFLAGS="${LDFLAGS} -static"
    echo "${CC} ${CFLAGS}" > conf-cc
    echo "${CC} ${LDFLAGS}" > conf-ld
    echo "/usr" > conf-home
    emake || die "emake failed"
}

src_install() {
	into /usr
	dobin 822addr 822body 822bodyfilter 822fields 822headerfilter \
		  822headerok 822headers checkaddr checkdomain \
		  condtomaildir filterto ifaddr iftoccfrom replier \
		  replier-config tomaildir
	
	dodoc BAPVERSION CHANGES FILES README SYSDEPS TARGETS TODO VERSION
}
