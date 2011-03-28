# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/jigdo/jigdo-0.7.3-r1.ebuild,v 1.2 2011/03/28 17:05:49 angelos Exp $

EAPI=3
inherit eutils

DESCRIPTION="Jigsaw Download is a tool designed to ease the distribution of large files, for example DVD images."
HOMEPAGE="http://atterer.net/jigdo/"
SRC_URI="http://atterer.net/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="gtk nls berkdb libwww"

RDEPEND="gtk? ( x11-libs/gtk+:2 )
	berkdb? ( >=sys-libs/db-3.2 )
	libwww? ( >=net-libs/libwww-5.3.2 )"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

src_prepare() {
	epatch "${FILESDIR}"/${P}-gcc43.patch \
		"${FILESDIR}"/${P}-strip.patch
}

src_configure() {
	local myconf

	use gtk && use libwww || myconf="${myconf} --without-gui"
	use berkdb || myconf="${myconf} --without-libdb"

	econf $(use_enable nls) ${myconf}
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc changelog README THANKS doc/{Hacking,README-bindist,TechDetails}.txt
	dohtml doc/*.html
}
