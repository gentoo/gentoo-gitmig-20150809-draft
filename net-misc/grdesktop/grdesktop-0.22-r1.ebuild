# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/grdesktop/grdesktop-0.22-r1.ebuild,v 1.2 2004/02/22 00:17:04 cyfred Exp $

DESCRIPTION="Gtk2 frontend for rdesktop"
HOMEPAGE="http://www.nongnu.org/grdesktop"
SRC_URI="http://savannah.nongnu.org/download/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~sparc"

IUSE=""

RDEPEND=">=x11-libs/gtk+-2.0.6-r3
	>=net-misc/rdesktop-1.1.0.19.9.0
	>=gnome-base/libgnomeui-2.2
	>=gnome-base/gconf-2"

DEPEND="${RDEPEND}
	doc? ( app-text/docbook2X )
	app-text/scrollkeeper"

S="${WORKDIR}/${P}"

src_compile() {
	econf \
	    --with-keymap-path=/usr/share/rdesktop/keymaps \
		--localstatedir=${D}/var/lib || die "./configure failed"

	# For some reason we have duplicate syntax in Makefiles, removing
	epatch ${FILESDIR}/0010_all_0.22-remove-double-makefile-syntax.patch

	emake || die
}

src_install() {
	#einstall
	make DESTDIR=${D} install || die "couldnt install"

	dodoc AUTHORS ABOUT-NLS COPYING ChangeLog INSTALL NEWS README TODO
}
