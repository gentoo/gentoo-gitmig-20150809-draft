# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/cpio/cpio-2.5.90.ebuild,v 1.1 2004/12/17 19:38:39 vapier Exp $

inherit eutils

DESCRIPTION="A file archival tool which can also read and write tar files"
HOMEPAGE="http://www.gnu.org/software/cpio/cpio.html"
SRC_URI="mirror://gnu/cpio/${P}.tar.bz2"

LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~ppc-macos ~s390 ~sh ~sparc ~x86"
IUSE=""

DEPEND="virtual/libc"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-gnulib.patch
	epatch ${FILESDIR}/${PV}-makepath.patch
	epatch ${FILESDIR}/${PV}-rili-big-files.patch
}

src_compile() {
	econf \
		--bindir=/bin \
		--with-rmt=/usr/sbin/rmt \
		|| die
	emake || die
}

src_install() {
	make install DESTDIR="${D}" || die
	dodoc ChangeLog NEWS README INSTALL
	rm -f "${D}"/usr/share/man/man1/mt.1
	rmdir "${D}"/usr/libexec
}
