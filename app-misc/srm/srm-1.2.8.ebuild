# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/srm/srm-1.2.8.ebuild,v 1.1 2004/06/07 08:51:54 dragonheart Exp $

DESCRIPTION="A command-line compatible rm which destroys file contents before unlinking."
HOMEPAGE="http://sourceforge.net/projects/srm"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
RESTRICT="nomirror"
KEYWORDS="~x86 ~amd64"
LICENSE="X11"
SLOT="0"
IUSE=""

DEPEND="virtual/glibc
	sys-apps/gawk
	sys-apps/grep"

RDEPEND="virtual/glibc"

src_install () {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc README Changes        || die "dodoc failed"
}

pkg_postinst() {
	echo
	ewarn "Please notice that srm will not work as expected with any"
	ewarn "journaled file system (e.g. reiserfs, ext3)."
	ewarn "Please read /usr/share/doc/${P}/README.gz"
	echo
}
