# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/imposter/imposter-0.3.ebuild,v 1.2 2006/01/19 16:52:41 suka Exp $

inherit eutils

DESCRIPTION="Imposter is a standalone viewer for the presentations created by OpenOffice.org Impress software"
HOMEPAGE="http://imposter.sourceforge.net/"

SRC_URI="mirror://sourceforge/imposter/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"

IUSE="iksemel"
DEPEND="dev-libs/atk
	x11-libs/pango
	dev-libs/glib
	dev-util/pkgconfig
	>=x11-libs/gtk+-2.4.0
	iksemel? ( >=dev-libs/iksemel-1.2 )"

src_unpack() {
	unpack ${A}
	cd ${S}
	# Patch by Recai OktaÅŸ <roktas@omu.edu.tr>, backported from CVS...
	epatch "${FILESDIR}/${P}-ignore-modifiers.patch"
}

src_compile() {
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die
}
