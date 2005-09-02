# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/multipath-tools/multipath-tools-0.4.5.ebuild,v 1.1 2005/09/02 15:01:44 azarah Exp $

inherit toolchain-funcs

DESCRIPTION="Device mapper target autoconfig."
HOMEPAGE="http://christophe.varoqui.free.fr/wiki/wakka.php?wiki=Home"
SRC_URI="http://christophe.varoqui.free.fr/${PN}/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"

IUSE=""

RDEPEND=">=sys-fs/device-mapper-1.00.19
	sys-fs/udev
	sys-fs/sysfsutils"

DEPEND="${RDEPEND}"

src_unpack() {
	unpack ${A}; cd ${S}
	sed -i -e 's:^bindir.*:bindir = /usr/sbin:' \
		${S}/multipathd/Makefile
	sed -i -e 's:rules.d/.*:rules.d/40-multipath.rules:' \
		${S}/multipath/Makefile
}

src_compile() {
	emake -j1 \
		CC=$(tc-getCC) || die "emake failed"
}

src_install() {
	dodir /sbin /usr/share/man/man8
	make DESTDIR=${D} install || die "install failed"

	insinto /etc
	newins ${S}/multipath.conf.annotated multipath.conf
	fperms 644 /etc/udev/rules.d/multipath.rules
	newinitd ${FILESDIR}/rc-multipathd multipathd

	dodoc AUTHOR COPYING ChangeLog FAQ README TODO
	docinto dmadm; dodoc README
	docinto kpartx; dodoc ChangeLog README
}
