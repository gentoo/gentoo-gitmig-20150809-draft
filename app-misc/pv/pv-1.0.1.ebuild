# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/pv/pv-1.0.1.ebuild,v 1.2 2007/08/18 03:12:00 angelos Exp $

inherit eutils

DESCRIPTION="Pipe Viewer: a tool for monitoring the progress of data through a pipe"
HOMEPAGE="http://www.ivarch.com/programs/pv.shtml"
SRC_URI="mirror://sourceforge/pipeviewer/${P}.tar.gz"

LICENSE="Artistic-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="debug nls"

DEPEND="virtual/libc"

src_compile() {
	econf \
		$(use_enable nls) \
		$(use_enable debug debugging) \
		|| die "configure failed"

	emake || die "make failed"
}

src_install() {
	make DESTDIR=${D} UNINSTALL=/bin/true install || die "install failed"

	dodoc README doc/NEWS doc/TODO
}
