# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-antivirus/bitdefender-console/bitdefender-console-7.0.1.ebuild,v 1.1 2004/11/20 15:41:44 ticho Exp $

inherit rpm

DESCRIPTION="Complete virus defense solution designed for easy virus prevention on Linux systems."
HOMEPAGE="http://www.bitdefender.com/bd/site/products.php?p_id=16"
SRC_URI="ftp://ftp.bitdefender.com/pub/linux/free/bitdefender-console/en/BitDefender-Console-Antivirus-${PV}-3.linux-gcc3x.i586.rpm"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="app-arch/rpm2targz"

src_unpack() {
	rpm_src_unpack ${DISTDIR}/${A} || die "Could not unpack RPM package"
}

src_install() {
	dodir /opt/bdc
	cp -Rf ${WORKDIR}/opt/* ${D}/opt

	# Create a symlink for bdc executable
	dodir /usr/bin
	dosym /opt/bdc/bdc /usr/bin/bdc

	# Install manpage correctly and remove it from /opt, where it's
	# useless
	doman ${WORKDIR}/opt/bdc/man/bdc.1
	rm -rf ${D}/opt/bdc/man
}

