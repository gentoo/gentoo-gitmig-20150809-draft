# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/gnome-mousetrap/gnome-mousetrap-0.3.ebuild,v 1.1 2009/11/22 17:06:12 mrpouet Exp $

EAPI="2"
GCONF_DEBUG="no"

inherit eutils gnome2

MY_PV=${PV}+svn17
MY_P=${PN}_${MY_PV}
PATCHLEVEL=3

DESCRIPTION="Standalone application that allows users with physical impairments to move a mouse cursor"
HOMEPAGE="http://live.gnome.org/MouseTrap"
SRC_URI="mirror://debian/pool/main/g/${PN}/${MY_P}.orig.tar.gz
	mirror://debian/pool/main/g/${PN}/${MY_P}-${PATCHLEVEL}.diff.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

RDEPEND="gnome-extra/at-spi
	media-libs/opencv[python]
	dev-python/python-xlib"
DEPEND="${RDEPEND}
	dev-util/intltool"

S=${WORKDIR}/${PN}-${MY_PV}

pkg_setup() {
	G2CONF="--disable-dependency-tracking
		$(use_enable doc pydoc)"
}
src_prepare() {
	gnome2_src_prepare
	epatch "${WORKDIR}/${MY_P}-${PATCHLEVEL}.diff"

	# Use a specific version of python is a bad thing
	sed 's:/usr/bin/python2.5:/usr/bin/python:g' \
		-i src/mouseTrap/mousetrap.in || die "sed failed"
}
