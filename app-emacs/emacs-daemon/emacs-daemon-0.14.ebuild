# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/emacs-daemon/emacs-daemon-0.14.ebuild,v 1.6 2009/04/16 01:38:08 jer Exp $

inherit elisp

DESCRIPTION="Gentoo support for Emacs running as a server in the background"
HOMEPAGE="http://www.gentoo.org/proj/en/lisp/emacs/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~s390 ~sh ~sparc ~x86"
IUSE=""

DEPEND=">=virtual/emacs-23"
RDEPEND="${DEPEND}
	>=sys-apps/openrc-0.4"

SITEFILE="10${PN}-gentoo.el"

pkg_setup() {
	local has_daemon=$(${EMACS} ${EMACSFLAGS} \
		--eval "(princ (fboundp 'daemonp))")
	if [ "${has_daemon}" != t ]; then
		ewarn "Your current Emacs version does not support running as a daemon"
		ewarn "which is required for ${CATEGORY}/${PN}."
		ewarn "Use \"eselect emacs\" to select an Emacs version >= 23."
	fi
}

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
