# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/libnasl/libnasl-2.0.5.ebuild,v 1.1 2003/05/13 10:21:27 phosphan Exp $

inherit eutils

DESCRIPTION="A remote security scanner for Linux (libnasl)"
HOMEPAGE="http://www.nessus.org/"
SRC_URI="ftp://ftp.nessus.org/pub/nessus/nessus-${PV}/src/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc -sparc "

DEPEND="=net-analyzer/nessus-libraries-${PV}"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-gentoo.patch || die
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
	
	make || die "make failed"
	# fails for >= -j2. bug #16471.
	# emake || die "emake failed"
}

src_install() {
	make \
		prefix=${D}/usr \
		sysconfdir=${D}/etc \
		localstatedir=${D}/var/lib \
		mandir=${D}/usr/share/man \
		install || die "Install failed libnasl"
	dodoc COPYING TODO
}
