# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/procman/procman-1.0.ebuild,v 1.23 2005/01/01 11:19:40 eradicator Exp $

inherit flag-o-matic

DESCRIPTION="Process viewer for GNOME"
HOMEPAGE="http://www.personal.psu.edu/kfv101/procman"
SRC_URI="mirror://gnome/sources/procman/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc sparc x86"
IUSE="nls"

DEPEND="<gnome-extra/gal-1.99
	=gnome-base/libgtop-1.0*"
RDEPEND="nls? ( sys-devel/gettext )"

src_compile() {
	append-flags $(gdk-pixbuf-config --cflags)
	econf \
		--disable-more-warnings \
		$(use_enable nls) \
		|| die "econf failed"
	emake || die
}

src_install() {
	make install DESTDIR="${D}" || die
	dodoc AUTHORS ChangeLog README NEWS TODO
}
