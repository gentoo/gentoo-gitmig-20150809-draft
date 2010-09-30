# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libgpod/libgpod-0.7.95.ebuild,v 1.1 2010/09/30 09:10:41 ford_prefect Exp $

EAPI=2
inherit eutils mono

DESCRIPTION="Shared library to access the contents of an iPod"
HOMEPAGE="http://www.gtkpod.org/libgpod/"
SRC_URI="mirror://sourceforge/gtkpod/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+gtk python +udev iphone mono"

RDEPEND=">=dev-libs/glib-2.16
	sys-apps/sg3_utils
	dev-libs/libxml2
	>=app-pda/libplist-1.0
	gtk? ( >=x11-libs/gtk+-2.6 )
	iphone? ( app-pda/libimobiledevice )
	python? ( >=dev-lang/python-2.3
		>=media-libs/mutagen-1.8
		>=dev-python/pygobject-2.8 )
	udev? ( sys-fs/udev )
	mono? ( >=dev-lang/mono-1.9.1
		>=dev-dotnet/gtk-sharp-2.12 )"
DEPEND="${RDEPEND}
	python? ( >=dev-lang/swig-1.3.24 )
	dev-util/pkgconfig
	dev-libs/libxslt"

src_configure() {
	econf \
		--without-hal \
		$(use_enable udev) \
		$(use_enable gtk gdk-pixbuf) \
		$(use_enable python pygobject) \
		$(use_with python) \
		$(use_with mono) \
		$(use_with iphone libimobiledevice)
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc README TROUBLESHOOTING AUTHORS NEWS README.SysInfo
}
