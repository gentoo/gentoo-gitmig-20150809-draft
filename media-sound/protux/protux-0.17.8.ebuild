# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/protux/protux-0.17.8.ebuild,v 1.4 2004/02/09 18:58:06 eradicator Exp $

inherit kde-functions

DESCRIPTION="Professional Audio Tools for GNU/Linux"
HOMEPAGE="http://www.nongnu.org/protux"
SRC_URI="http://savannah.nongnu.org/download/protux/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

S="${WORKDIR}/${P}"

RDEPEND="virtual/x11
	>=x11-libs/qt-3
	=media-libs/libmustux-0.17*"

DEPEND="${RDEPEND}
	sys-devel/automake
	sys-devel/autoconf"

set-qtdir 3

src_compile() {
	export QT_MOC=${QTDIR}/bin/moc
	cd ${S}
	export WANT_AUTOMAKE=1.4
	export WANT_AUTOCONF=2.1
	make -f admin/Makefile.common
	econf
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYRIGHT ChangeLog FAQ README TODO
}
