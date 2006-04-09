# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/qtparted/qtparted-0.4.4-r1.ebuild,v 1.6 2006/04/09 16:14:56 herbs Exp $

inherit qt3 multilib

DESCRIPTION="nice Qt partition tool for Linux"
HOMEPAGE="http://qtparted.sourceforge.net/"
SRC_URI="mirror://sourceforge/qtparted/${P}.tar.bz2"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE=""

DEPEND="$(qt_min_version 3.1)
	>=sys-apps/parted-1.6.7
	>=sys-fs/e2fsprogs-1.33
	>=sys-fs/xfsprogs-2.3.9
	>=sys-fs/jfsutils-1.1.2
	>=sys-fs/ntfsprogs-1.7.1"

RDEPEND="${DEPEND}
	x11-libs/gksu"

src_compile() {
	local myconf="--disable-reiserfs
				--enable-labels
				--with-qt-libraries=${QTDIR}/$(get_libdir)"

	econf ${myconf} || die "configure failed"
	emake || die "make failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
	dodoc doc/README doc/README.Debian doc/TODO.txt doc/BUGS doc/DEVELOPER-FAQ
}
