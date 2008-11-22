# Copyright 2003-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/nip2/nip2-7.16.3.ebuild,v 1.1 2008/11/22 23:28:12 maekke Exp $

inherit fdo-mime versionator

DESCRIPTION="VIPS Image Processing Graphical User Interface"
SRC_URI="http://www.vips.ecs.soton.ac.uk/supported/$(get_version_component_range 1-2)/${P}.tar.gz"
HOMEPAGE="http://vips.sourceforge.net"

SLOT="0"
LICENSE="GPL-2"

KEYWORDS="~amd64 ~ppc ~x86"

IUSE="fftw"

RDEPEND="
	>=dev-libs/glib-2
	dev-libs/libxml2
	>=media-libs/vips-${PV}
	>=x11-libs/gtk+-2.4
	fftw? ( >=sci-libs/fftw-3 )"

# Flex and bison are build dependencies, but are not needed at runtime
DEPEND="${RDEPEND}
	=sys-devel/bison-2.3*
	sys-devel/flex"

src_compile() {
	econf \
		--disable-update-desktop \
		$(use_with fftw fftw3)
	emake || die "emake failed"
}

src_install() {
	# create these dirs to make the makefile installs these items correctly
	dodir /usr/share/{applications,application-registry,mime-info}

	insinto /usr/share/pixmaps
	doins "${FILESDIR}"/nip2.png
	insinto /usr/share/applications
	doins "${FILESDIR}"/nip2.desktop
	insinto /usr/share/mime/packages
	doins "${FILESDIR}"/nip2.xml

	einstall || die "einstall failed"
	dodoc AUTHORS ChangeLog NEWS README* || die
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
}
