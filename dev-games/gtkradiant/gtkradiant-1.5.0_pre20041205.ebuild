# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/gtkradiant/gtkradiant-1.5.0_pre20041205.ebuild,v 1.1 2004/12/09 04:35:27 vapier Exp $

inherit eutils games rpm

DS="${PV/*_pre}"
DESCRIPTION="FPS level editor"
HOMEPAGE="http://www.qeradiant.com/?data=editors/gtk"
SRC_URI="http://zerowing.idsoftware.com/files/radiant/nightly/${PV:0:3}/gtkradiant-${PV/_pre*}-${DS:0:4}-${DS:4:2}-${DS:6:2}.i386.rpm"

LICENSE="qeradiant"
SLOT="0"
KEYWORDS="-* x86"
IUSE=""

RDEPEND="media-libs/libpng
	sys-libs/zlib
	=dev-libs/glib-2*
	=x11-libs/gtk+-2*
	dev-libs/atk
	x11-libs/pango
	x11-libs/gtkglext
	dev-libs/libxml2
	virtual/x11
	virtual/opengl"

S="${WORKDIR}/opt/${PN}"

src_install() {
	local dir="${GAMES_PREFIX_OPT}/${PN}"
	dodir "${dir}"

	cp -a * "${D}/${dir}/"
	games_make_wrapper q3map2 ./q3map2.x86 "${dir}"
	games_make_wrapper radiant ./radiant.x86 "${dir}"

	prepgamesdirs
}
