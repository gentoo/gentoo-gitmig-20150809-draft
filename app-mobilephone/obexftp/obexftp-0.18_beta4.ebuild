# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-mobilephone/obexftp/obexftp-0.18_beta4.ebuild,v 1.2 2006/01/03 19:32:44 mrness Exp $

DESCRIPTION="File transfer over OBEX for mobile phones"
SRC_URI="http://triq.net/obexftp/beta-testing/${P}.tar.gz"
HOMEPAGE="http://triq.net/obex"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="bluetooth perl python tcltk"

DEPEND=">=dev-libs/openobex-1.0.0
	bluetooth? ( >=net-wireless/bluez-libs-2.19 )
	perl? ( >=dev-lang/perl-5.8.6 )
	python? ( >=dev-lang/python-2.4.2 )
	tcltk? ( >=dev-lang/tcl-8.4.9 )"

S="${WORKDIR}/${P%_*}"

src_compile() {
	econf $(use_enable bluetooth) \
		$(use_enable perl) \
		$(use_enable python) \
		$(use_enable tcltk tcl) \
		|| die "configure failed"
	emake || die "make failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
	dodoc AUTHORS ChangeLog README* THANKS TODO
}
