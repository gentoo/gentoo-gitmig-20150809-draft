# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/emul-linux-x86-soundlibs/emul-linux-x86-soundlibs-2.1.ebuild,v 1.2 2005/05/22 10:13:17 blubb Exp $

DESCRIPTION="Sound libraries for emulation of 32bit x86 on amd64"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI="mirror://gentoo/emul-linux-x86-soundlibs-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* amd64"
IUSE=""

RDEPEND=">=app-emulation/emul-linux-x86-baselibs-2.0"

S=${WORKDIR}

src_install() {
	cp -RPvf ${WORKDIR}/* ${D}/
}
