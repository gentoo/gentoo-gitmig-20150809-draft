# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/gphoto2/gphoto2-2.4.4.ebuild,v 1.1 2009/01/31 16:51:43 eva Exp $

inherit eutils

DESCRIPTION="free, redistributable digital camera software application"
HOMEPAGE="http://www.gphoto.org/"
SRC_URI="mirror://sourceforge/gphoto/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="aalib exif ncurses nls readline"

# aalib -> needs libjpeg
# raise libgphoto to get a proper .pc
RDEPEND=">=dev-libs/libusb-0.1.8
	dev-libs/popt
	>=media-libs/libgphoto2-2.4.4
	ncurses? ( dev-libs/cdk )
	aalib? (
		media-libs/aalib
		media-libs/jpeg )
	exif? (	media-libs/libexif )
	readline? ( sys-libs/readline )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	nls? ( >=sys-devel/gettext-0.14 )"

pkg_setup() {
	if use exif && ! built_with_use media-libs/libgphoto2 exif; then
		eerror "exif support required but libgphoto2 does not have it."
		die "rebuild media-libs/libgphoto2 with USE=\"exif\"."
	fi
}

src_compile() {
	econf \
		--docdir=/usr/share/doc/${PF} \
		$(use_with aalib) \
		$(use_with aalib jpeg) \
		$(use_with exif) \
		$(use_with ncurses cdk) \
		$(use_enable nls) \
		$(use_with readline)
	emake || die "compilation failed"
}

src_install() {
	emake DESTDIR="${D}" \
		HTML_DIR="${D}"/usr/share/doc/${PF}/sgml \
		install || die "installation failed"

	dodoc ChangeLog NEWS* README AUTHORS || die "dodoc failed"
	rm -rf "${D}"/usr/share/doc/${PF}/sgml/gphoto2
}
