# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/libnasl/libnasl-1.2.6.ebuild,v 1.4 2003/02/13 13:42:41 vapier Exp $

S=${WORKDIR}/${PN}

DESCRIPTION="A remote security scanner for Linux (libnasl)"
HOMEPAGE="http://www.nessus.org/"
SRC_URI="ftp://ftp.nessus.org/pub/nessus/nessus-${PV}/src/${P}.tar.gz"

DEPEND="=net-analyzer/nessus-libraries-${PV}"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc -sparc "

src_unpack() {
	unpack ${A}
	cd ${S}
	patch -p1 < ${FILESDIR}/nasl.diff
}

src_compile() {
        if [ ! -z ${DEBUG} ]; then
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
	docinto libnasl
	dodoc COPYING TODO
}
