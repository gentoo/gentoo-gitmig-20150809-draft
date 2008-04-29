# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/jigdo/jigdo-0.7.3.ebuild,v 1.7 2008/04/29 19:12:02 drac Exp $

inherit eutils

DESCRIPTION="Jigsaw Download, or short jigdo, is a tool designed to ease the distribution of very large files over the internet, for example CD or DVD images."
HOMEPAGE="http://atterer.net/jigdo/"
SRC_URI="http://atterer.net/jigdo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"
IUSE="gtk nls berkdb libwww"

RDEPEND="gtk? ( >=x11-libs/gtk+-2 )
	berkdb? ( >=sys-libs/db-3.2 )
	libwww? ( >=net-libs/libwww-5.3.2 )"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-gcc43.patch
}

src_compile() {
	local myconf

	use gtk && use libwww || myconf="${myconf} --without-gui"
	use berkdb || myconf="${myconf} --without-libdb"

	econf $(use_enable nls) ${myconf}
	emake || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc changelog README THANKS doc/{Hacking,README-bindist,TechDetails}.txt
	dohtml doc/*.html
}
