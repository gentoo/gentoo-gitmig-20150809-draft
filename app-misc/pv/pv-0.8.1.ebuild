# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/pv/pv-0.8.1.ebuild,v 1.7 2004/10/18 22:14:11 kloeri Exp $

DESCRIPTION="Pipe Viewer: a tool for monitoring the progress of data through a pipe"
HOMEPAGE="http://www.ivarch.com/programs/pv.shtml"
SRC_URI="mirror://sourceforge/pipeviewer/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64 ~sparc ~alpha"
IUSE=""

DEPEND="virtual/libc"

src_install() {
	make DESTDIR=${D} UNINSTALL=/bin/true install || die "install failed"
}
