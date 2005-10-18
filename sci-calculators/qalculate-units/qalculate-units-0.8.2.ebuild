# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-calculators/qalculate-units/qalculate-units-0.8.2.ebuild,v 1.1 2005/10/18 17:12:13 ribosome Exp $

DESCRIPTION="A GTK+ unit conversion tool"
LICENSE="GPL-2"
HOMEPAGE="http://qalculate.sourceforge.net/"
SRC_URI="mirror://sourceforge/qalculate/${P}.tar.gz"

SLOT="0"
IUSE="nls"
KEYWORDS="~x86"

DEPEND="=sci-libs/libqalculate-0.8.2*
	>=x11-libs/gtk+-2.4
	nls? ( sys-devel/gettext )"

src_install() {
	make install DESTDIR="${D}" || die "Installation failed."
	dodoc AUTHORS ChangeLog README || die "Failed to install documentation."
}
