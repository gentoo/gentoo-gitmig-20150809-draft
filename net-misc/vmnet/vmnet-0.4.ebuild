# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/vmnet/vmnet-0.4.ebuild,v 1.1 2003/07/28 01:51:26 robbat2 Exp $

DESCRIPTION="A simple virtual networking program"
HOMEPAGE="ftp://ftp.xos.nl/pub/linux/${PN}/"
# The main site is often down
# So this might be better but it's a different filename
# http://ftp.debian.org/debian/pool/main/${PN:0:1}/${PN}/${P/-/_}.orig.tar.gz
# We use the debian patch anyway
SRC_URI="ftp://ftp.xos.nl/pub/linux/${PN}/${P}.tar.gz 
	http://ftp.debian.org/debian/pool/main/${PN:0:1}/${PN}/${P/-/_}-1.diff.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="sys-apps/net-tools"
S=${WORKDIR}/${P}

src_unpack() {
	unpack ${P}.tar.gz
	epatch ${DISTDIR}/${P/-/_}-1.diff.gz
}

src_compile() {
	emake || die "Emake failed"
}

src_install() {
	# Binary
	into /usr
	dobin ${PN}
	# This line doesn't seem to work?
	# fperms 4755 ${PN}
	chmod 4755 ${D}/usr/bin/${PN}
	
	# Docs
	doman ${PN}.1
	dodoc COPYING README debian/${PN}.sgml
	
	# Config file
	into /etc
	doins debian/${PN}.conf
}

pkg_postinst() {
	einfo "Don't forgot to ensure SLIP support is in your kernel!"
}
