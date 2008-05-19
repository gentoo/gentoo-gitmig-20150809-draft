# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/imposter/imposter-0.3.ebuild,v 1.4 2008/05/19 17:04:30 nixnut Exp $

inherit eutils

DESCRIPTION="Imposter is a standalone viewer for the presentations created by OpenOffice.org Impress software"
HOMEPAGE="http://imposter.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc ~x86"
IUSE="iksemel nls"

RDEPEND=">=x11-libs/gtk+-2.4
	iksemel? ( dev-libs/iksemel )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	# Patch by Recai OktaÅŸ <roktas@omu.edu.tr>, backported from CVS...
	epatch "${FILESDIR}"/${P}-ignore-modifiers.patch
}

src_compile() {
	# FIXME. Iksemel is automagic depend.
	econf --disable-dependency-tracking $(use_enable nls)
	emake || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog NEWS README TODO
}
