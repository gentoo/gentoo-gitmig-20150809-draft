# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/ghex/ghex-1.2.1.ebuild,v 1.14 2004/05/31 22:12:03 vapier Exp $

DESCRIPTION="Gnome Hexadecimal editor"
HOMEPAGE="http://pluton.ijs.si/~jaka/gnome.html"
SRC_URI="http://pluton.ijs.si/~jaka/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="1"
KEYWORDS="x86 ppc sparc"
IUSE="nls"

RDEPEND="=x11-libs/gtk+-1.2*
	 >=gnome-base/gnome-libs-1.4.1.2-r3
	 >=gnome-base/ORBit-0.5.12-r1
	 >=gnome-base/gnome-print-0.34
	 >=app-text/scrollkeeper-0.2"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

src_compile() {
	local myconf=""
	use nls || myconf="$myconf --disable-nls" #default enabled

	econf ${myconf} || die
	emake || die
}

src_install() {
	make \
		prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		GNOME_DATA_DIR=${D}/usr/share \
		localstatedir=${D}/var \
		install || die "Installation Failed"

	dodoc AUTHORS ChangeLog INSTALL NEWS README
}
