# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/istanbul/istanbul-0.2.0.ebuild,v 1.3 2007/01/22 02:20:49 compnerd Exp $

inherit eutils gnome2

KEYWORDS="~x86 ~amd64"

HOMEPAGE="http://live.gnome.org/Istanbul"
LICENSE="GPL-2"
SLOT=0
DESCRIPTION="Istanbul is a screencast application for the Unix desktop"
IUSE=""

RDEPEND=">=media-libs/gst-plugins-base-0.10.8
	dev-lang/python
	>=dev-python/pygtk-2.6
	>=dev-python/gnome-python-extras-2.11.3
	>=gnome-base/gconf-2.0
	>=dev-python/gst-python-0.10.0
	media-plugins/gst-plugins-ogg
	media-plugins/gst-plugins-theora
	>=media-libs/libtheora-1.0_alpha6"

DEPEND="${RDEPEND}"
SRC_URI="http://zaheer.merali.org/${P}.tar.bz2"

src_compile() {
	mkdir -p "${T}/home"
	export HOME="${T}/home"
	export GST_REGISTRY=${T}/home/registry.cache.xml
	addpredict /root/.gconfd
	addpredict /root/.gconf
	econf
	emake
}
