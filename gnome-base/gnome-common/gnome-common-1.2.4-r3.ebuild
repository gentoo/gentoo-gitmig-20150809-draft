# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gnome-common/gnome-common-1.2.4-r3.ebuild,v 1.16 2004/01/10 03:09:35 agriffis Exp $

inherit flag-o-matic
# Do _NOT_ strip symbols in the build!
RESTRICT="nostrip"
append-flags -g

DESCRIPTION="Some Common files for Gnome2 applications"
HOMEPAGE="http://www.gnome.org/"
SRC_URI="ftp://ftp.gnome.org/pub/gnome/sources/${PN}/1.2/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="2"
KEYWORDS="x86 ppc sparc alpha hppa amd64 ia64"

RDEPEND=">=dev-libs/glib-2.0.0"
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0"

src_compile() {
	./configure --host=${CHOST} \
		--prefix=/usr \
		--sysconfdir=/etc \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		--enable-debug=yes || die "configure failure"
	emake || die "compile failure"
}

src_install() {
	make prefix=${D}/usr \
		sysconfdir=${D}/etc \
		infodir=${D}/usr/share/info \
		mandir=${D}/usr/share/man \
		install || die "install failure"

	dodoc AUTHORS ChangeLog COPYING README* INSTALL NEWS
}
