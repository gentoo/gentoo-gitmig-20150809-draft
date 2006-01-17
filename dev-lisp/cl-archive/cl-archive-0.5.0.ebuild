# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-archive/cl-archive-0.5.0.ebuild,v 1.1 2006/01/17 08:06:48 mkennedy Exp $

inherit common-lisp eutils

DESCRIPTION="A Common Lisp library for reading and writing cpio and tar archives."
HOMEPAGE="http://www.cliki.net/tar"
SRC_URI="http://www.cs.rice.edu/~froydnj/lisp/archive_${PV}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND="dev-lisp/cl-trivial-gray-streams
	dev-lisp/cl-flexi-streams"

CLPACKAGE=archive

S=${WORKDIR}/archive_${PV}

src_install() {
	common-lisp-install *.{lisp,asd}
	common-lisp-system-symlink
	dodoc TODO NEWS LICENSE README
}
