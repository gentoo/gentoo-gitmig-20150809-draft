# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/gtkpod/gtkpod-0.85.0.ebuild,v 1.5 2005/04/01 19:59:56 hansmi Exp $

DESCRIPTION="GUI for iPod using GTK2"
HOMEPAGE="http://gtkpod.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~amd64 ~sparc ppc"
IUSE="aac"

DEPEND=">=x11-libs/gtk+-2.4.0
	>=media-libs/libid3tag-0.15
	aac? ( || ( media-libs/faad2 media-video/mpeg4ip ) )"

src_install() {
	einstall || die
	dodoc README ${DISTDIR}/Local_Playcounts.README
}
