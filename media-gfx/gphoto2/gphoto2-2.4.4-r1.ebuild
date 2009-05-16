# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/gphoto2/gphoto2-2.4.4-r1.ebuild,v 1.2 2009/05/16 07:57:19 robbat2 Exp $

EAPI="2"

DESCRIPTION="free, redistributable digital camera software application"
HOMEPAGE="http://www.gphoto.org/"
SRC_URI="mirror://sourceforge/gphoto/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86"
IUSE="aalib exif ncurses nls readline"

# aalib -> needs libjpeg
RDEPEND="=virtual/libusb-0*
	dev-libs/popt
	>=media-libs/libgphoto2-2.4.4[exif?]
	ncurses? ( dev-libs/cdk )
	aalib? (
		media-libs/aalib
		media-libs/jpeg )
	exif? (	media-libs/libexif )
	readline? ( sys-libs/readline )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	nls? ( >=sys-devel/gettext-0.14 )"

src_configure() {
	econf \
		--docdir=/usr/share/doc/${PF} \
		$(use_with aalib) \
		$(use_with aalib jpeg) \
		$(use_with exif libexif) \
		$(use_with ncurses cdk) \
		$(use_enable nls) \
		$(use_with readline)
}

src_install() {
	emake DESTDIR="${D}" \
		HTML_DIR="${D}"/usr/share/doc/${PF}/sgml \
		install || die "installation failed"

	dodoc ChangeLog NEWS* README AUTHORS || die "dodoc failed"
	rm -rf "${D}"/usr/share/doc/${PF}/sgml/gphoto2
}
