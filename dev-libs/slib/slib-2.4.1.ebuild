# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-libs/slib/slib-2.4.1.ebuild,v 1.4 2001/11/10 12:05:20 hallski Exp $

P=slib2d1
S=${WORKDIR}/slib
DESCRIPTION=""
SRC_URI="http://swissnet.ai.mit.edu/ftpdir/scm/${P}.tar.gz"
HOMEPAGE="http://swissnet.ai.mit.edu/~jaffer/SLIB.html"

RDEPEND=">=dev-util/guile-1.4"

DEPEND="${RDEPEND}
	>=app-arch/unzip-5.21
	>=dev-util/guile-1.4"

src_install () {
	insinto /usr/share/guile/site/slib
	doins *.scm
	dodoc ANNOUNCE ChangeLog FAQ README
	doinfo slib.info
}

pkg_postinst () {
	if [ "${ROOT}" == "/" ]
	then
	echo "Installing..."
		guile -c "(use-modules (ice-9 slib)) (require 'new-catalog)" "/" 
	fi
}
