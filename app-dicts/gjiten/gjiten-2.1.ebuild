# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/gjiten/gjiten-2.1.ebuild,v 1.2 2003/06/12 19:52:47 msterret Exp $

DESCRIPTION="A Japanese dictionary program for Gnome"
SRC_URI="http://gjiten.sourceforge.net/${P}.tar.gz"
HOMEPAGE="http://gjiten.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=gnome-base/libgnome-2.2
	>=gnome-base/libgnomeui-2.2
	>=x11-libs/gtk+-2"

RDEPEND="gnome-base/libgnome
	x11-libs/gtk+"

src_compile() {
	econf || die
	emake || die
}

src_install() {
	einstall || die
	dodoc ABOUT-NLS AUTHORS Changelog COPYING INSTALL NEWS README THANKS TODO
	dohtml index.html gjiten.xml legal.xml gjiten-doc.ja.html
}
pkg_postinst() {
	einfo
	einfo "Dictionary files are necessary in order for"
	einfo "Gjiten to function."
	einfo
	einfo "Download dictionary files from:"
	einfo "http://ftp.cc.monash.edu.au/pub/nihongo/00INDEX.html#dic_fil"
	einfo "You need kanjidic and edict at a minimum.  Dictionary files"
	einfo "must be converted to UTF-8 format - check the Gjiten help"
	einfo "and README files for details."
	einfo 
	einfo "A shell script is available from "
	einfo "the Gjiten homepage(${HOMEPAGE}) to"
	einfo "download and convert the dictionary files, but you need"
	einfo "to put the files in /usr/share/gjiten after running the script."
	einfo
}

