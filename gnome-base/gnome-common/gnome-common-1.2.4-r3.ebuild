# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gnome-common/gnome-common-1.2.4-r3.ebuild,v 1.20 2004/11/08 14:52:37 vapier Exp $

inherit flag-o-matic gnome.org

DESCRIPTION="Some Common files for Gnome2 applications"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2"
SLOT="2"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc sparc x86"
IUSE=""
RESTRICT="nostrip" # Do _NOT_ strip symbols in the build!

RDEPEND=">=dev-libs/glib-2.0.0"
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0"

src_compile() {
	append-flags -g
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

	dodoc AUTHORS ChangeLog README* INSTALL NEWS
}
