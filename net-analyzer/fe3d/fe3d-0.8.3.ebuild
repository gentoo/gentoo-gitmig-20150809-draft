# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/fe3d/fe3d-0.8.3.ebuild,v 1.8 2008/01/26 11:14:30 pva Exp $

inherit versionator autotools

MY_P="${PN}-$(replace_version_separator 2 '-')"

DESCRIPTION="A 3D visualization tool for network security information"
HOMEPAGE="http://projects.icapsid.net/fe3d/"
SRC_URI="http://projects.icapsid.net/${PN}/src/${MY_P}.src.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 x86"
IUSE=""

RDEPEND="media-libs/libsdl
	media-libs/sdl-ttf
	media-libs/libpng
	>=dev-libs/xerces-c-2.5.0"
DEPEND="${RDEPEND}
	app-arch/unzip
	virtual/opengl"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd "${S}"

	# configure is not executable, remove it as autoreconf recreate it
	rm configure
	# autoreconf is required as in other case build system will call wrong
	# automake utilities, bug 205543
	eautoreconf
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc doc/{ChangeLog,versions}.txt
}

pkg_postinst() {
	elog "Example using a nmap log:"
	elog "/usr/bin/nmap -oX test.xml -O --osscan_limit 192.168.0.0/24"
	elog "/usr/bin/fe3d test.xml"
}
