# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/sound-juicer/sound-juicer-0.1-r1.ebuild,v 1.1 2003/04/23 11:44:38 foser Exp $

inherit gnome2 eutils

DESCRIPTION="CD ripper for GNOME 2"
HOMEPAGE="http://www.burtonini.com/"
SRC_URI="http://www.burtonini.com/computing/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

IUSE=""

RDEPEND=">=dev-libs/glib-2
	>=gnome-base/libglade-2
	>=gnome-base/gconf-1.2
	>=gnome-base/libgnomeui-2
	>=media-libs/gstreamer-0.6.1
	>=media-libs/gst-plugins-0.6.1
	>=media-libs/musicbrainz-2.0.1"

DEPEND="${RDEPEND}
	>=dev-util/intltool-0.20
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}

	# i'm a paranoid android <foser@gentoo.org>
	epatch ${FILESDIR}/${P}-paranoia-r1.patch
	# do not break configure when not finding certain plugins
	epatch ${FILESDIR}/${P}-warn_plugins_missing.patch
	# nice handling of missing plugins
	epatch ${FILESDIR}/${P}-nocrash_on_missing_plugins.patch
	# avoid / in file name 
	epatch ${FILESDIR}/${P}-avoid_illegal_filename.patch

	cd ${S}
	autoconf || die
}

DOCS="AUTHORS COPYING ChangeLog INSTALL NEWS README TODO"

SCROLLKEEPER_UPDATE="0"
