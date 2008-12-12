# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/gimmix/gimmix-0.5.3.ebuild,v 1.3 2008/12/12 19:31:49 angelos Exp $

inherit eutils

DESCRIPTION="a graphical music player daemon (MPD) client using GTK+2"
HOMEPAGE="http://gimmix.berlios.de/"
SRC_URI="mirror://berlios/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86"
IUSE="cover lyrics"

RDEPEND=">=x11-libs/gtk+-2.6
	>=gnome-base/libglade-2.6
	>=media-libs/libmpd-0.12
	>=media-libs/taglib-1.4
	cover? ( net-libs/libnxml net-misc/curl )
	lyrics? ( net-libs/libnxml net-misc/curl )"
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9
	dev-util/intltool"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${P}-missing-prototypes.patch
	echo "src/eggtrayicon.c" >> "${S}"/po/POTFILES.skip
	echo "src/gimmix-covers.c" >> "${S}"/po/POTFILES.skip
	echo "src/gimmix-lyrics.c" >> "${S}"/po/POTFILES.skip
}

src_compile() {
	econf $(use_enable cover) $(use_enable lyrics)
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README TODO
}

pkg_postinst() {
	elog "gimmix-0.4 introduces a new config file format."
	elog "If you're upgrading from an older version please"
	elog "delete your ~/.gimmixrc before running gimmix."
}
