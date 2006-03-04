# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/gjiten/gjiten-2.5.ebuild,v 1.1 2006/03/04 08:29:16 matsuu Exp $

inherit eutils gnome2

DESCRIPTION="A Japanese dictionary program for Gnome"
HOMEPAGE="http://gjiten.sourceforge.net/"
SRC_URI="http://gjiten.sourceforge.net/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

IUSE=""

RDEPEND=">=gnome-base/libgnome-2.2
	>=gnome-base/libgnomeui-2.2
	>=gnome-base/libglade-2.0"
DEPEND="${RDEPEND}
	app-text/scrollkeeper
	>=dev-util/intltool-0.22
	app-text/docbook-sgml-utils"

DOCS="AUTHORS BUGS ChangeLog NEWS README TODO"

src_unpack() {
	unpack ${A}
	cd "${S}"
	gnome2_omf_fix help/omf.make
	epatch "${FILESDIR}"/${P}-gentoo.patch

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
