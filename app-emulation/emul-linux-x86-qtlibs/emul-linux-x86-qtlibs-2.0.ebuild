# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/emul-linux-x86-qtlibs/emul-linux-x86-qtlibs-2.0.ebuild,v 1.2 2005/04/16 05:53:49 mr_bones_ Exp $

DESCRIPTION="QT 2/3 libraries for emulation of 32bit x86 on amd64"
SRC_URI="http://fermat.ma.rhul.ac.uk/~herbie/emul/emul-linux-x86-qtlibs-${PV}.tar.bz2"
HOMEPAGE="http://www.gentoo.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="-* ~amd64"
IUSE=""

DEPEND="virtual/libc
	>=app-emulation/emul-linux-x86-xlibs-2.0"

src_install() {
	cd ${WORKDIR}

	# create env.d entry
	mkdir -p ${D}/etc/env.d
	cat > ${D}/etc/env.d/45emul-linux-x86-qtlibs <<ENDOFENV
	LDPATH=/emul/linux/x86/usr/qt/2/lib:/emul/linux/x86/usr/qt/3/lib
	QTDIR=/emul/linux/x86/usr/qt/2:/emul/linux/x86/usr/qt/3
ENDOFENV
	chmod 644 ${D}/etc/env.d/45emul-linux-x86-qtlibs

	cp -Rpvf ${WORKDIR}/* ${D}/
}
