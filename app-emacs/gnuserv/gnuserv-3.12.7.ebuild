# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/gnuserv/gnuserv-3.12.7.ebuild,v 1.5 2007/05/19 16:02:05 ulm Exp $

inherit elisp eutils

DESCRIPTION="Attach to an already running Emacs"
HOMEPAGE="http://meltin.net/hacks/emacs/"
SRC_URI="http://meltin.net/hacks/emacs/src/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="X"

DEPEND="X? ( x11-libs/libXau )"
RDEPEND="${DEPEND}"

SITEFILE=50${PN}-gentoo.el

src_compile() {
	# bug #83112
	unset LDFLAGS

	econf $(use_enable X xauth) \
		--x-includes=/usr/X11R6/include \
		--x-libraries=/usr/X11R6/lib || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	einstall man1dir="${D}"/usr/share/man/man1 || die "einstall failed"

	elisp-install ${PN} *.el *.elc
	elisp-site-file-install ${FILESDIR}/${SITEFILE}

	dodoc ChangeLog README README.orig || die "dodoc failed"
}
