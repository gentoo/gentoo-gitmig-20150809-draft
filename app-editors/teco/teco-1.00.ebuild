# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/teco/teco-1.00.ebuild,v 1.2 2003/05/16 16:21:29 taviso Exp $

# "Real mans editor" quote from package's lsm ;)
DESCRIPTION="Classic TECO editor, Predecessor to EMACS.  Real mans editor."
HOMEPAGE="http://www.ibiblio.org/pub/linux/apps/editors/tty/"
SRC_URI="http://www.ibiblio.org/pub/linux/apps/editors/tty/teco.tar.gz"
LICENSE="freedist"
SLOT="0"
KEYWORDS="~alpha ~x86"
IUSE=""
DEPEND="virtual/glibc
	sys-libs/libtermcap-compat
	>=sys-apps/sed-4"
RDEPEND="virtual/glibc
	sys-libs/libtermcap-compat"
S=${WORKDIR}

src_compile() {
	sed -i 's/CFLAGS = -O//' Makefile 
	emake || die "compilation failed"
}

src_install() {
	insinto /usr/bin
	dobin te
	dodoc sample.tecorc sample.tecorc2 READ.ME MANIFEST
	doman te.1
}

pkg_postinst() {
	einfo "The TECO binary is called te."
	einfo "Sample configurations are available in /usr/share/doc/"
}
