# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/denemo/denemo-0.7.4.ebuild,v 1.2 2005/12/02 10:10:23 metalgod Exp $

inherit flag-o-matic

DESCRIPTION="GTK+ graphical music notation editor"
HOMEPAGE="http://denemo.sourceforge.net/"
SRC_URI="mirror://sourceforge/denemo/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND="=x11-libs/gtk+-1.2*
	dev-libs/libxml"

DEPEND="${RDEPEND}
	dev-util/yacc
	sys-devel/flex
	sys-devel/gettext"

src_compile() {
	append-flags -fpermissive
	econf || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
}
