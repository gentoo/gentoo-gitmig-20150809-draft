# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/urjtag/urjtag-0.8.ebuild,v 1.1 2008/02/26 04:36:36 vapier Exp $

inherit eutils

DESCRIPTION="tool for communicating over JTAG with flash chips, CPUs, and many more (fork of openwince jtag)"
HOMEPAGE="http://urjtag.sourceforge.net/"
SRC_URI="mirror://sourceforge/urjtag/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="readline"

DEPEND="readline? ( sys-libs/readline )"

src_compile() {
	use realine || export vl_cv_lib_readline=no
	econf || die
	emake || die
}

src_install() {
	emake DESTDIR="${D}" install || die "failed to install"
	dodoc AUTHORS ChangeLog NEWS README THANKS
}
