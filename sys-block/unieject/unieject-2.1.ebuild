# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-block/unieject/unieject-2.1.ebuild,v 1.5 2005/07/25 19:25:49 gustavoz Exp $

DESCRIPTION="Multiplatform command to eject and load CD-Rom drives"
HOMEPAGE="http://dev.gentoo.org/~flameeyes/projects.xhtml"
SRC_URI="http://digilander.libero.it/dgp85/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND=">=dev-libs/libcdio-0.75-r1
	dev-libs/popt
	!virtual/eject"
DEPEND="${RDEPEND}
	app-text/txt2man"

PROVIDE="virtual/eject"

src_install() {
	make DESTDIR="${D}" install
	dodoc README ChangeLog NEWS

	# Symlink to eject to provide a good virtual/eject
	dosym unieject.1.gz /usr/share/man/man1/eject.1.gz
	dosym unieject /usr/bin/eject
}
