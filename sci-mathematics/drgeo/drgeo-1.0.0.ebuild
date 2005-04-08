# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/drgeo/drgeo-1.0.0.ebuild,v 1.1 2005/04/08 14:40:31 cryos Exp $

DOCN="${PN}-doc"
DOCV="1.5"
DOC="${DOCN}-${DOCV}"

DESCRIPTION="Interactive geometry package"
LICENSE="GPL-2"
HOMEPAGE="http://www.ofset.org/drgeo"
SRC_URI="mirror://sourceforge/ofset/${P}.tar.gz
	mirror://sourceforge/ofset/${DOC}.tar.gz"

SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc"
IUSE="nls no-helpbrowser"

DEPEND=">=x11-libs/gtk+-2
	>=gnome-base/libglade-2
	>=dev-libs/libxml2-2
	>=dev-util/guile-1.4
	!no-helpbrowser? ( www-client/dillo )"

src_compile() {
	econf || die "econf failed."
	emake || die "emake failed."
	# Can't make the documentation as it depends on Hyperlatex which isn't
	# yet in portage. Fortunately HTML is already compiled for us in the
	# tarball and so can be installed. Just create the make install target.
	cd ${WORKDIR}/${DOC}
	econf || die "docs econf failed."
}

src_install() {
	make install DESTDIR=${D} || die "make install failed."
	dodoc AUTHORS ChangeLog README NEWS TODO
	if use nls; then
		cd ${WORKDIR}/${DOC}
	else
		cd ${WORKDIR}/${DOC}/c
	fi
	make install DESTDIR=${D} || die "docs make installation failed."
}
