# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/rp-l2tp/rp-l2tp-0.4.ebuild,v 1.3 2004/11/20 10:16:54 mrness Exp $

inherit eutils

DESCRIPTION="RP-L2TP is a user-space implementation of L2TP for Linux and other UNIX systems"
HOMEPAGE="http://sourceforge.net/projects/rp-l2tp/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
DEPEND="virtual/libc"
LICENSE="GPL-2"
KEYWORDS="x86 ~amd64 ~ppc"
SLOT="0"
IUSE=""

src_unpack() {
	unpack ${A} || die "failed to unpack sources"
	cd ${S} || die "source dir not found"
	epatch ${FILESDIR}/${P}-gentoo.diff || die "failed to apply patch"
}

src_compile() {
	econf || die "configure failed"
	emake || die "make failed"
}

src_install() {
	make RPM_INSTALL_ROOT=${D} install || die "make install failed"

	dodoc README
	newdoc l2tp.conf rp-l2tpd.conf
	cp -a libevent/Doc ${D}/usr/share/doc/${PF}/libevent

	exeinto /etc/init.d
	newexe ${FILESDIR}/rp-l2tpd-init rp-l2tpd
}
