# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/gi-detect/gi-detect-0.1.ebuild,v 1.4 2003/06/22 05:10:31 seemant Exp $

DESCRIPTION="Python interface to detect."
HOMEPAGE="http://sourceforge.net/projects/linbrew/"
SRC_URI="mirror://sourceforge/linbrew/GI_Detect-0.1.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
DEPEND="sys-apps/discover
        sys-libs/detect"
S="${WORKDIR}/GI_Detect-0.1"

src_compile() {
        python setup.py build || die
}

src_install () {
        python setup.py install --root=${D} --prefix=/usr || die
        dodoc API INSTALL example.py
}

