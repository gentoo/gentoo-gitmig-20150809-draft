# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/dasher/dasher-3.2.1.ebuild,v 1.1 2004/03/17 22:23:13 leonardop Exp $

inherit gnome2

DESCRIPTION="A text entry interface that is driven by continuous use of a pointing device, such as a mouse or eyetracker"
HOMEPAGE="http://www.inference.phy.cam.ac.uk/${PN}/"
SRC_URI="http://www.inference.phy.cam.ac.uk/${PN}/download/linux/source/3.2/${P}.tar.gz"
LICENSE="GPL-2"

IUSE="gnome nls accessibility"
SLOT="0"
KEYWORDS="~x86"

# The archive claims 'qte' support, but wont compile with QT
# Need to wait for upstream <obz@gentoo.org>
RDEPEND="dev-libs/expat
	>=x11-libs/gtk+-2
	>=gnome-base/gconf-2
	>=gnome-base/libglade-2
	gnome? ( >=gnome-base/libgnome-2
		>=gnome-base/gnome-vfs-2
		>=gnome-base/libgnomeui-2 )
	accessibility? ( >=gnome-base/libbonobo-2
		>=gnome-base/ORBit2-2
		>=gnome-base/libgnomeui-2
		app-accessibility/gnome-speech
		>=gnome-extra/at-spi-1 )"

DEPEND="${RDEPEND}
	>=dev-util/intltool-0.18
	dev-util/pkgconfig"

DOCS="ABOUT-NLS AUTHORS COPYING ChangeLog INSTALL README"

src_compile() {

	local myconf=""
	use nls || myconf="${myconf} --disable-nls"
	use gnome && myconf="${myconf} --enable-gnome"
	use accessibility && myconf="${myconf} --enable-a11y --enable-speech"

	gnome2_src_compile ${myconf}

}

