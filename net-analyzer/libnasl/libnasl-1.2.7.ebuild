# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/libnasl/libnasl-1.2.7.ebuild,v 1.2 2003/01/17 03:38:30 raker Exp $

S=${WORKDIR}/${PN}
DESCRIPTION="A remote security scanner for Linux (libnasl)"
HOMEPAGE="http://www.nessus.org/"
SRC_URI="ftp://ftp.nessus.org/pub/nessus/nessus-${PV}/src/${P}.tar.gz"
DEPEND="=net-analyzer/nessus-libraries-${PV}"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc -sparc "

inherit eutils

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/nasl.diff || die
}

src_compile() {
        if [ ! -z ${DEBUGBUILD} ]; then
                OLD_DEBUG=${DEBUG}
                unset DEBUG
                econf || die "configuration failed"
                DEBUG=${OLD_DEBUG}
                unset OLD_DEBUG
        else
                econf || die "configuration failed"
        fi
        emake || die "emake failed"
}

src_install() {
	make \
		prefix=${D}/usr \
		sysconfdir=${D}/etc \
		localstatedir=${D}/var/lib \
		mandir=${D}/usr/share/man \
		install || die "Install failed libnasl"
	cd ${S}
	dodoc COPYING TODO
}
