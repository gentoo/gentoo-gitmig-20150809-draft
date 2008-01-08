# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/drgeo/drgeo-1.1.0.ebuild,v 1.5 2008/01/08 00:37:47 bicatali Exp $

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
	>=dev-scheme/guile-1.4"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

pkg_setup() {
	if has_version =dev-scheme/guile-1.8*; then
		built_with_use dev-scheme/guile deprecated \
		|| die "guile must be built with deprecated use flag"
	fi
}

src_compile() {
	econf || die "econf failed."
	emake || die "emake failed."
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
