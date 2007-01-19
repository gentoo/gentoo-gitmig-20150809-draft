# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/imposter/imposter-0.2.ebuild,v 1.8 2007/01/19 14:20:36 masterdriverz Exp $

DESCRIPTION="Imposter is a standalone viewer for the presentations created by OpenOffice.org Impress software"
HOMEPAGE="http://imposter.sourceforge.net/"

SRC_URI="mirror://sourceforge/imposter/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"

IUSE=""
DEPEND="dev-libs/atk
	x11-libs/pango
	dev-libs/glib
	dev-util/pkgconfig
	>=x11-libs/gtk+-2.0.3"

src_compile() {
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die
}
