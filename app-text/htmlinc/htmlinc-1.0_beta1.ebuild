# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/htmlinc/htmlinc-1.0_beta1.ebuild,v 1.1 2002/06/23 23:34:28 carpaski Exp $

DESCRIPTION="HTML Include System by Ulli Meybohm"
HOMEPAGE="http://www.meybohm.de/"
LICENSE="GPL"
DEPEND=""
SRC_URI="http://meybohm.de/files/htmlinc.tar.gz"
S=${WORKDIR}/htmlinc

src_compile() {
	emake CFLAGS="${CXXFLAGS} -Wall" || die
}

src_install () {
	dobin htmlinc
}
