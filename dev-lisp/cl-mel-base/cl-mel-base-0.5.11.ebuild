# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-mel-base/cl-mel-base-0.5.11.ebuild,v 1.1 2004/11/25 08:53:46 mkennedy Exp $

inherit common-lisp eutils

MY_PV=${PV:0:3}-${PV:4}

DESCRIPTION="A Common Lisp networking library for handling e-mail from Maildir, POP3, IMAP and SMTP"
HOMEPAGE="http://codeartist.org/mel/"
SRC_URI="http://dataheaven.dnsalias.net/asdf-install/mel-base_${MY_PV}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="-*"
IUSE=""

DEPEND="dev-lisp/common-lisp-controller
	virtual/commonlisp"

CLPACKAGE=mel-base

S=${WORKDIR}/mel-base_${MY_PV}

src_install() {
	insinto ${CLSOURCEROOT}/${CLPACKAGE}/
	doins *.lisp mel-base.asd
	for dir in folders/* lisp-dep protocols; do
		insinto ${CLSOURCEROOT}/${CLPACKAGE}/${dir}
		doins ${dir}/*.lisp
	done
	common-lisp-system-symlink
	dodoc LICENSE
}

# TODO:
# * looks for /etc/mime.types at runtime (determine dep)
# * CLOS-related build failure CMUCL