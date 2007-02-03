# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/gmrun/gmrun-0.9.2.ebuild,v 1.13 2007/02/03 12:54:10 nelchael Exp $

inherit autotools

DESCRIPTION="A GTK-2 based launcher box with bash style auto completion!"
HOMEPAGE="http://www.bazon.net/mishoo/gmrun.epl"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-1"
SLOT="0"
KEYWORDS="x86 amd64 ppc ~sparc"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2.2.0
	dev-libs/popt"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	cd "${S}"
	# Disable check for STLport due to bug #164339
	sed -i -e 's,^AC_PATH_STLPORT,dnl REMOVED ,g' configure.in
	sed -i -e 's,@STLPORT_[A-Z]\+@,,g' src/Makefile.am
	eautoreconf
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog README NEWS
}

pkg_postinst(){
	einfo
	einfo "Gmrun now featers a ~/.gmrunrc see /usr/share/gmrun/gmrunrc for help"
	einfo
}
