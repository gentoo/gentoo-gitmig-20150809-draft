# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/cpio/cpio-2.6-r2.ebuild,v 1.2 2005/03/30 19:12:01 wolf31o2 Exp $

inherit eutils

DESCRIPTION="A file archival tool which can also read and write tar files"
HOMEPAGE="http://www.gnu.org/software/cpio/cpio.html"
SRC_URI="mirror://gnu/cpio/${P}.tar.bz2"

LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 ppc-macos s390 sh sparc x86"
IUSE="nls"

DEPEND="virtual/libc"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PV}-rili-big-files.patch #68520
	epatch "${FILESDIR}"/${PV}-isnumber.patch #74929
	epatch "${FILESDIR}"/${PV}-umask.patch #79844
	epatch "${FILESDIR}"/${PV}-lstat.patch #80246
}

src_compile() {
	econf \
		$(use_enable nls) \
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
