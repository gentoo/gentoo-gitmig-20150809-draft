# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/srm/srm-1.2.7.ebuild,v 1.6 2004/06/28 04:14:35 vapier Exp $

DESCRIPTION="A command-line compatible rm which destroys file contents before unlinking."
HOMEPAGE="http://sourceforge.net/projects/srm/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="X11"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""

DEPEND="virtual/libc"
RDEPEND="virtual/libc
	!app-misc/secure-delete"

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc README Changes
}

pkg_postinst() {
	ewarn "Please notice that srm will not work as expected with any"
	ewarn "journaled file system (e.g. reiserfs, ext3)."
	ewarn "Please read /usr/share/doc/${P}/README.gz"
}
