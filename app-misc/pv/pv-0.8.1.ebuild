# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/pv/pv-0.8.1.ebuild,v 1.2 2004/04/20 07:35:29 dholm Exp $

DESCRIPTION="Pipe Viewer: a tool for monitoring the progress of data through a pipe"
HOMEPAGE="http://www.ivarch.com/programs/pv.shtml"
SRC_URI="mirror://sourceforge/pipeviewer/${P}.tar.gz"
LICENSE="Artistic"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc"
DEPEND="virtual/glibc"

src_compile() {
	econf || die "configure failed"
	emake || die "make failed"
}
src_install() {
	make DESTDIR=${D} UNINSTALL=/bin/true install || die "install failed"
}
