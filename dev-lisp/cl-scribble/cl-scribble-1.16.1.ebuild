# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-scribble/cl-scribble-1.16.1.ebuild,v 1.3 2005/05/24 18:48:35 mkennedy Exp $

inherit common-lisp

DESCRIPTION="Scribble is a Library that extends the Common Lisp reader with the text markup syntax of Scribe."
HOMEPAGE="http://www.cliki.net/Scribble"
SRC_URI="http://ftp.debian.org/debian/pool/main/c/${PN}/${PN}_${PV}.orig.tar.gz"
LICENSE="No-Problem-Bugroff"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc x86"
IUSE=""
DEPEND="dev-lisp/cl-meta"

CLPACKAGE=scribble

src_install() {
	common-lisp-install *.asd *.lisp
	common-lisp-system-symlink
}
