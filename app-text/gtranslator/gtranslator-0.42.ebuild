# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/gtranslator/gtranslator-0.42.ebuild,v 1.9 2003/06/10 13:14:13 liquidx Exp $

DESCRIPTION="A gettext po file editor for GNOME"
SRC_URI="http://www.gtranslator.org/download/releases/${PV}/${P}.tar.gz"
HOMEPAGE="http://www.gtranslator.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc"
IUSE="nls"

DEPEND=">=gnome-base/gnome-libs-1.2
	=gnome-base/gconf-1.0*
	<gnome-extra/gal-1.99
	=dev-libs/glib-1.2*
	=x11-libs/gtk+-1.2*
	>=gnome-base/oaf-0.6.8
	>=gnome-base/ORBit-0.5.14
	=gnome-base/gnome-vfs-1*
	>=dev-libs/libxml-1.8.17"
RDEPEND=">=app-text/scrollkeeper-0.1.4
	nls? ( sys-devel/gettext )"

src_compile() {
	econf `use_enable nls`
	emake || die
}

src_install() {
	cd ${S}/help/C
	mv Makefile Makefile.orig
	sed -e 's:scrollkeeper-update.*::g' Makefile.orig > Makefile
	rm Makefile.orig

	cd ${S}
	make DESTDIR=${D} install || die

	dodoc ABOUT-NLS AUTHORS Changelog COPYING HACKING INSTALL NEWS README \
		THANKS TODO DEPENDS 
}

pkg_postinst() {
	echo ">>> Updating Scrollkeeper database..."
	scrollkeeper-update >/dev/null 2>&1
}

pkg_postrm() {
	echo ">>> Updating Scrollkeeper database..."
	scrollkeeper-update >/dev/null 2>&1
}
