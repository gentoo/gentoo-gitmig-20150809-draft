# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-trivial-sockets/cl-trivial-sockets-0.2.ebuild,v 1.6 2006/01/02 17:11:17 mkennedy Exp $

inherit common-lisp eutils

DESCRIPTION="A portable Common Lisp networking library for undemanding Internet clients"
HOMEPAGE="http://www.cliki.net/trivial-sockets
	http://cvs.telent.net/cgi-bin/viewcvs.cgi/trivial-sockets/"
SRC_URI="http://ftp.linux.org.uk/pub/lisp/cclan/trivial-sockets_${PV}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc x86"
IUSE=""
DEPEND="dev-lisp/common-lisp-controller
	virtual/commonlisp"

S=${WORKDIR}/trivial-sockets_${PV}

CLPACKAGE=trivial-sockets

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${PV}-asdf-depends-gentoo.patch || die
}

src_install() {
	common-lisp-install *.lisp *.asd
	common-lisp-system-symlink
	dodoc README
}
