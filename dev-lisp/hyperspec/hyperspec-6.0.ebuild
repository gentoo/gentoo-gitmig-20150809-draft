# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/hyperspec/hyperspec-6.0.ebuild,v 1.6 2005/03/18 08:07:01 mkennedy Exp $

inherit elisp

DESCRIPTION="Common Lisp ANSI-standard Hyperspec"
HOMEPAGE="http://www.lispworks.com/reference/HyperSpec/"
SRC_URI=""
LICENSE="HyperSpec"
SLOT="0"
KEYWORDS="x86 ~amd64"
IUSE=""
DEPEND=""

# URL: ftp://ftp.xanalys.com/pub/software_tools/reference/HyperSpec-6-0.tar.gz

src_unpack() {
	if [ ! -f ${DISTDIR}/HyperSpec-6-0.tar.gz ] ; then
		echo
		einfo ">>> The HyperSpec cannot be redistributed.  Download the HyperSpec-6-0.tar.gz "
		einfo ">>> file from http://www.lispworks.com/reference/HyperSpec/ and move it to "
		einfo ">>> /usr/portage/distfiles before rerunning emerge.  The legal conditions are "
		einfo ">>> described at http://www.lispworks.com/reference/HyperSpec/Front/Help.htm#Legal"
		die
	fi
}

src_compile() {
	einfo ">>> Nothing to compile."
}

src_install() {
	dodir /usr/share/doc/${P}
	cd ${D}/usr/share/doc/${P} && tar xfz ${DISTDIR}/HyperSpec-6-0.tar.gz || die
}

