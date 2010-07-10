# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/drgeo/drgeo-1.1.0.ebuild,v 1.7 2010/07/10 15:00:26 xarthisius Exp $

EAPI="2"

inherit eutils

DOCN="${PN}-doc"
DOCV="1.5"
DOC="${DOCN}-${DOCV}"

DESCRIPTION="Interactive geometry package"
LICENSE="GPL-2"
HOMEPAGE="http://www.ofset.org/drgeo"
SRC_URI="mirror://sourceforge/ofset/${P}.tar.gz
	mirror://sourceforge/ofset/${DOC}.tar.gz"

SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE="nls"

RDEPEND=">=x11-libs/gtk+-2
	>=gnome-base/libglade-2
	>=dev-libs/libxml2-2
	|| (
		>=dev-scheme/guile-1.8[deprecated]
		=dev-scheme/guile-1.6*
	)"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_prepare() {
	epatch "${FILESDIR}"/${P}-gcc45.patch
}

src_configure() {
	default
	# Can't make the documentation as it depends on Hyperlatex which isn't
	# yet in portage. Fortunately HTML is already compiled for us in the
	# tarball and so can be installed. Just create the make install target.
	cd "${WORKDIR}"/${DOC}
	econf || die "docs econf failed."
}

src_install() {
	emake install DESTDIR="${D}" || die "emake install failed."
	dodoc AUTHORS ChangeLog README NEWS TODO || die
	if use nls; then
		cd "${WORKDIR}"/${DOC}
	else
		cd "${WORKDIR}"/${DOC}/c
	fi
	emake install DESTDIR="${D}" || die "emake docs installation failed"

}
