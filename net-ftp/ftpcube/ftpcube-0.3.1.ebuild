# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/ftpcube/ftpcube-0.3.1.ebuild,v 1.1 2002/05/28 00:04:31 bass Exp $ 

S=${WORKDIR}/${P}
DESCRIPTION="A graphical FTP client written in Python with GTK bindings."
SRC_URI="http://unc.dl.sourceforge.net/sourceforge/ftpcube/${P}.tar.gz"
HOMEPAGE="http://ftpcube.sourceforge.net/"
LICENSE="Artistic"
DEPEND="dev-python/pygtk"
RDEPEND="${DEPEND}"
SLOT="0"

src_unpack() {
	unpack ftpcube-0.3.1.tar.gz
	cd ${WORKDIR}/ftpcube-0.3.1
	patch setup.cfg < ${FILESDIR}/setup.cfg.patch || die "config patch failed"
}

src_compile() {
   python setup.py build || die "make failed"
}

src_install () {
    python setup.py install || die "install failed"
}
	
