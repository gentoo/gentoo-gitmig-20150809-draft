# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-rsm-rsa/cl-rsm-rsa-1.3.20040328.ebuild,v 1.3 2005/02/05 21:48:47 mkennedy Exp $

inherit common-lisp eutils

MY_PV=${PV:0:3}
CVS_PV=${PV:4:4}.${PV:8:2}.${PV:10}

DESCRIPTION="McIntire's Common Lisp RSA Library"
HOMEPAGE="http://packages.debian.org/unstable/devel/${PN}.html"
SRC_URI="http://ftp.debian.org/debian/pool/main/c/${PN}/cl-rsm-rsa_${MY_PV}+cvs.${CVS_PV}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="dev-lisp/cl-rsm-mod
	dev-lisp/cl-rsm-string
	dev-lisp/cl-plus"

CLPACKAGE=rsm-rsa

S=${WORKDIR}/cl-rsm-rsa-${MY_PV}+cvs.${CVS_PV}

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${PV}-defconstant-gentoo.patch || die
}

src_install() {
	common-lisp-install *.lisp *.asd
	common-lisp-system-symlink
	dodoc copying copyright
	dohtml *.html *.jpg
	do-debian-credits
}
