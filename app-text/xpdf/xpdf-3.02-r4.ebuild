# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/xpdf/xpdf-3.02-r4.ebuild,v 1.9 2011/02/17 13:50:24 aballier Exp $

EAPI=2

inherit fdo-mime gnome2 eutils flag-o-matic toolchain-funcs

DESCRIPTION="An X Viewer for PDF Files"
HOMEPAGE="http://www.foolabs.com/xpdf/"
SRC_URI="http://gentooexperimental.org/~genstef/dist/${P}-poppler-20071121.tar.bz2
	mirror://gentoo/xpdf-3.02-patchset-02.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ~ppc64 sh sparc x86 ~x86-fbsd"
IUSE="nodrm"

RDEPEND="
	>=app-text/poppler-0.12.3-r3[xpdf-headers]
	>=x11-libs/openmotif-2.3:0
	x11-libs/libX11
	x11-libs/libXpm
	"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S=${WORKDIR}/${P}-poppler

PATCHDIR="${WORKDIR}/${PV}"

pkg_setup() {
	append-flags '-DSYSTEM_XPDFRC="\"/etc/xpdfrc\""'
	# We know it's there, probably won't get rid of it, so let's make
	# the build output readable by removing it.
	einfo "Suppressing warning overload with -Wno-write-strings"
	append-cxxflags -Wno-write-strings
}

src_prepare() {
	export EPATCH_SUFFIX=patch
	export EPATCH_SOURCE="${PATCHDIR}"
	epatch
	use nodrm && epatch "${PATCHDIR}/xpdf-3.02-poppler-nodrm.patch"
	has_version '>=app-text/poppler-0.16' && epatch	"${FILESDIR}/${P}-poppler-0.16.patch"
	mv parseargs.c parseargs.cc
}

src_configure() {
	:
}

src_compile() {
	tc-export CXX
	emake || die
}

src_install() {
	dobin xpdf || die
	doman xpdf.1 || die
	insinto /etc || die
	doins "${PATCHDIR}"/xpdfrc || die
	dodoc README ANNOUNCE CHANGES || die
	doicon "${PATCHDIR}"/xpdf.png || die
	insinto /usr/share/applications || die
	doins "${PATCHDIR}"/xpdf.desktop || die
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
	gnome2_icon_cache_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
	gnome2_icon_cache_update
}
