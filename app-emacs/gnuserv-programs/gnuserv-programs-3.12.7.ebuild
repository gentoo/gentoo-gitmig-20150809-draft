# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/gnuserv-programs/gnuserv-programs-3.12.7.ebuild,v 1.6 2007/08/22 21:09:44 angelos Exp $

DESCRIPTION="Binary programs for app-emacs/gnuserv"
HOMEPAGE="http://meltin.net/hacks/emacs/"
SRC_URI="http://meltin.net/hacks/emacs/src/gnuserv-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE="X"

DEPEND="!app-editors/xemacs
	!<=app-emacs/gnuserv-3.12.7
	X? ( x11-libs/libXau )"
RDEPEND="${DEPEND}"
PDEPEND="~app-emacs/gnuserv-${PV}"

S="${WORKDIR}/gnuserv-${PV}"

src_compile() {
	# bug #83112
	unset LDFLAGS

	econf $(use_enable X xauth) \
		--x-includes=/usr/X11R6/include \
		--x-libraries=/usr/X11R6/lib || die "econf failed"
	emake ELC="" || die "emake failed"
}

src_install() {
	emake -j1 ELC="" \
		prefix="${D}"/usr \
		man1dir="${D}"/usr/share/man/man1 \
		install || die "emake install failed"
}
