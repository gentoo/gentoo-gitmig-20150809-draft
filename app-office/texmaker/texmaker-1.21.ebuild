# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/texmaker/texmaker-1.21.ebuild,v 1.4 2006/01/15 19:39:18 nattfodd Exp $

inherit eutils versionator

DESCRIPTION="a nice LaTeX-IDE"

# The upstream version numbering is bad, so we have to remove a dot in the
# minor version number
MAJOR="$(get_major_version)"
MINOR_1="$(($(get_version_component_range 2)/10))"
MINOR_2="$(($(get_version_component_range 2)%10))"
MY_P="${PN}-${MAJOR}.${MINOR_1}.${MINOR_2}"
S="${WORKDIR}/${MY_P}"
HOMEPAGE="http://www.xm1math.net/texmaker/"
SRC_URI="http://www.xm1math.net/texmaker/${MY_P}.tar.bz2"

LICENSE="GPL-2"

SLOT="0"

KEYWORDS="~x86 ~sparc ~ppc ~amd64"

IUSE=""

DEPEND="virtual/x11
	virtual/tetex
	app-text/psutils
	virtual/ghostscript
	media-libs/netpbm
	=x11-libs/qt-4.0*"

src_compile() {
	cd ${S}
	qmake -unix texmaker.pro || die "qmake failed"
	emake || die "emake failed"
}

src_install() {
	dobin texmaker || die "doexe failed"

	insinto /usr/share/pixmaps/texmaker
	doins utilities/texmaker*.png || die "doins failed."

	dodoc utilities/{AUTHORS,COPYING} || die "dodoc failed"

	dohtml utilities/*.{html,gif,css,txt} utilities/doc*.png || die "dohtml failed"

	dosym /usr/share/doc/${PF}/html /usr/share/${PN} || die "dosym failed"

	make_desktop_entry texmaker Texmaker "/usr/share/pixmaps/texmaker/texmaker48x48.png" Office
}

pkg_postinst() {
	einfo "A user manual with many screenshots is available at:"
	einfo "/usr/share/doc/${PF}/html/usermanual.html"
	einfo ""
	ewarn "texmaker-1.21 does not currently work with qt-4.1, only qt-4.0."
	ewarn "Unfortunately, portage can not handle this correctly yet, so it is"
	ewarn "possible that you obtain an infinite qt-4.0/qt-4.1 cycle in your emerge world."
	ewarn ""
	ewarn "If that happens, it is suggested to either mask qt-4.1"
	ewarn "  (echo \">=x11-libs/qt-4.1\" >> /etc/portage/package.mask)"
	ewarn "or downgrade texmaker."
}
