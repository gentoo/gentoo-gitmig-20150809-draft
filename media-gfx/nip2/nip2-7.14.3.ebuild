# Copyright 2003-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/nip2/nip2-7.14.3.ebuild,v 1.1 2008/04/27 15:27:54 maekke Exp $

inherit fdo-mime

DESCRIPTION="VIPS Image Processing Graphical User Interface"
SRC_URI="http://www.vips.ecs.soton.ac.uk/supported/7.14/${P}.tar.gz"
HOMEPAGE="http://vips.sourceforge.net"

SLOT="0"
LICENSE="GPL-2"

KEYWORDS="~ppc ~x86"

IUSE="fftw"

RDEPEND=">=media-libs/vips-7.14.1
	>=x11-libs/gtk+-2.4
	dev-libs/libxml2
	>=dev-libs/glib-2
	fftw? ( >=sci-libs/fftw-3 )"

# Flex and bison are build dependencies, but are not needed at runtime
DEPEND="${RDEPEND}
	sys-devel/flex
	sys-devel/bison"

src_compile() {
	local myconf
	use fftw || myconf="--without-fftw"
	econf ${myconf} || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	# create these dirs to make the makefile installs these items correctly
	dodir /usr/share/{applications,application-registry,mime-info}

	insinto	/usr/share/pixmaps
	doins "${FILESDIR}"/nip2.png
	insinto /usr/share/applications
	doins "${FILESDIR}"/nip2.desktop
	insinto /usr/share/mime/packages
	doins "${FILESDIR}"/nip2.xml

	einstall || die "einstall failed"
	dodoc AUTHORS ChangeLog NEWS README*
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
}
