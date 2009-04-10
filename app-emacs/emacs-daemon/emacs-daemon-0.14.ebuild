# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/emacs-daemon/emacs-daemon-0.14.ebuild,v 1.4 2009/04/10 18:37:42 armin76 Exp $

NEED_EMACS=23

inherit elisp

DESCRIPTION="Gentoo support for Emacs running as a server in the background"
HOMEPAGE="http://www.gentoo.org/proj/en/lisp/emacs/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~s390 ~sh ~sparc ~x86"
IUSE=""

RDEPEND=">=sys-apps/openrc-0.4"

SITEFILE="10${PN}-gentoo.el"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# compatibility code, to be removed later
	sed -i -e "/^(/i\\" \
		-e "(or (fboundp 'process-attributes)\\" \
		-e "    (defalias 'process-attributes 'system-process-attributes))" \
		${SITEFILE} || die "sed failed"
}

src_compile() { :; }

src_install() {
	newinitd emacs.rc emacs || die
	newconfd emacs.conf emacs || die
	exeinto /usr/libexec/emacs
	doexe emacs-wrapper.sh || die
	elisp-site-file-install "${SITEFILE}" || die
	keepdir /var/run/emacs || die
	dodoc README ChangeLog || die
}
