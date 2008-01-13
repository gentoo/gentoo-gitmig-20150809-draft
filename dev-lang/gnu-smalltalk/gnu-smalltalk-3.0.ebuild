# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/gnu-smalltalk/gnu-smalltalk-3.0.ebuild,v 1.1 2008/01/13 23:03:40 araujo Exp $

inherit elisp-common flag-o-matic eutils

DESCRIPTION="GNU Smalltalk"
HOMEPAGE="http://smalltalk.gnu.org"
SRC_URI="http://ftp.gnu.org/gnu/smalltalk/smalltalk-${PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="tk readline emacs gtk gmp"

DEPEND="sys-libs/gdbm
	sys-apps/debianutils
	!dev-libs/libsigsegv
	emacs? ( virtual/emacs )
	readline? ( sys-libs/readline )
	tk? ( dev-lang/tk )
	gtk? ( =x11-libs/gtk+-2* )
	gmp? ( dev-libs/gmp )"
RDEPEND=""

S="${WORKDIR}/smalltalk-${PV}"

SITEFILE=50gnu-smalltalk-gentoo.el

src_compile() {
	replace-flags '-O3' '-O2'
	./configure --prefix=/usr \
		`use_with emacs emacs` \
		`use_with readline readline` \
		`use_with gmp gmp` \
		`use_with tk tcl /usr/lib` \
		`use_with tk tk /usr/lib` \
		`use_enable gtk gtk` \
		|| die
	emake || die "emake failed"
	use emacs && elisp-compile *.el
}

src_install() {
	make prefix="${D}/usr" mandir="${D}/usr/share/man" \
		infodir="${D}/usr/share/info" \
		lispdir="${D}/usr/share/emacs/site-lisp/gnu-smalltalk" \
		libdir="${D}/usr/lib" install || die
	dodoc AUTHORS COPYING* ChangeLog NEWS README THANKS TODO
	if use emacs; then
		elisp-install "${PN}" *.el *.elc
		elisp-site-file-install "${FILESDIR}/${SITEFILE}"
	fi
	fperms 0444 /usr/share/smalltalk/packages.xml
}

pkg_postinst() {
	use emacs && elisp-site-regen
}

pkg_postrm() {
	use emacs && elisp-site-regen
}
