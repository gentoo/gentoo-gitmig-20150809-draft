# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/hcfusbmodem/hcfusbmodem-1.15.ebuild,v 1.1 2008/04/13 11:14:05 mrness Exp $

inherit linux-info eutils

DESCRIPTION="hcfusbmodem - Modem driver for Connexant HSF chipset"
SRC_URI="http://www.linuxant.com/drivers/hcf/full/archive/${P}powerpcfull.tar.gz"
HOMEPAGE="http://www.linuxant.com/drivers/"

IUSE=""
SLOT="0"
LICENSE="Conexant"
KEYWORDS="-* ~ppc"

DEPEND="dev-lang/perl
	app-arch/cpio"

S="${WORKDIR}/${P}powerpcfull"

QA_EXECSTACK="usr/lib/hcfusbmodem/modules/imported/hcfblam-powerpc.O usr/lib/hcfusbmodem/modules/imported/hcfengine-powerpc.O"

src_compile() {
	emake all || die "make failed"
}

src_install () {
	make PREFIX="${D}/usr/" ROOT="${D}" install || die "make install failed"
}

pkg_postinst() {
	if [ "${ROOT}" = / ]; then
		elog "To complete the installation and configuration of your HCF modem,"
		elog "please run hcfusbconfig."
	fi
}

pkg_prerm() {
	if [ "${ROOT}" = / -a -f /etc/init.d/hcfusb ] ; then
		hcfusbconfig --remove || die "hcfusbconfig --remove failed"
	fi
}
