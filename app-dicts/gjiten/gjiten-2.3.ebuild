# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/gjiten/gjiten-2.3.ebuild,v 1.3 2004/11/04 11:39:27 usata Exp $

inherit gnome2

DESCRIPTION="A Japanese dictionary program for Gnome"
HOMEPAGE="http://gjiten.sourceforge.net/"
SRC_URI="http://gjiten.sourceforge.net/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc ~amd64"

IUSE=""

RDEPEND=">=gnome-base/libgnome-2.2
	>=gnome-base/libgnomeui-2.2
	>=gnome-base/libglade-2.0"
DEPEND="${RDEPEND}
	app-text/scrollkeeper
	>=dev-util/intltool-0.22"

DOCS="AUTHORS BUGS ChangeLog INSTALL NEWS README TODO"

src_unpack() {
	unpack ${A}
	cd ${S}; gnome2_omf_fix help/omf.make
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

	gnome2_pkg_postinst
}
