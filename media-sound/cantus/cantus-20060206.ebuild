# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/cantus/cantus-20060206.ebuild,v 1.7 2007/08/12 10:29:35 drac Exp $

inherit eutils multilib

DESCRIPTION="Easy to use tool for tagging and renaming MP3 and OGG/Vorbis files"
HOMEPAGE="http://www.debain.org/software/cantus/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="sparc"
IUSE=""

RDEPEND="media-libs/libvorbis
	media-libs/libogg
	>=dev-cpp/gtkmm-2.4.0
	>=dev-cpp/libglademm-2.4.0"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/${PN}-gentoo.patch
}

src_compile() {
	GENTOO_LIBDIR="$(get_libdir)" ./build.sh --prefix /usr || die "Build failed"
}

src_install() {
	# this package has an amazingly stupid installer
	dodir /usr/$(get_libdir)
	GENTOO_LIBDIR="$(get_libdir)" ./build.sh --install --prefix ${D}/usr || die "Install failed"

	rm -rf "${D}"/usr/doc "${D}"/usr/share/gnome/help/cantus_3/C/figures/CVS/
	dodoc AUTHORS TODO README NEWS CHANGELOG

	insinto /usr/share/pixmaps
	newins ${FILESDIR}/${PN}.png ${PN}3.png

	insinto /usr/share/applications
	doins ${FILESDIR}/${PN}.desktop
}
