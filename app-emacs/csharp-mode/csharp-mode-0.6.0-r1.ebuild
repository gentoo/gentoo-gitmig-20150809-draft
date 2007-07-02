# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/csharp-mode/csharp-mode-0.6.0-r1.ebuild,v 1.1 2007/07/02 06:34:42 opfer Exp $

inherit elisp versionator

DESCRIPTION="A derived Emacs mode implementing most of the C# rules"
HOMEPAGE="http://mfgames.com/linux/csharp-mode"
SRC_URI="http://mfgames.com/linux/releases/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

NEED_CCMODE=5.30

DEPEND="|| ( >=app-emacs/cc-mode-${NEED_CCMODE} >=virtual/emacs-22 )"
RDEPEND="${DEPEND}"

SIMPLE_ELISP=t
SITEFILE=80${PN}-gentoo.el

pkg_setup () {
	local HAVE_CCMODE
	HAVE_CCMODE=$(emacs -batch -q \
		--eval "(and (require 'cc-mode nil t) (princ c-version))")
	if [ -z "${HAVE_CCMODE}" ] \
		|| ! version_is_at_least "${NEED_CCMODE}" "${HAVE_CCMODE}"; then
		eerror "This package needs at least cc-mode version ${NEED_CCMODE}."
		eerror "You should either install package app-emacs/cc-mode,"
		eerror "or use \"eselect emacs\" to select an Emacs version >= 22."
		die "cc-mode version ${HAVE_CCMODE} is too low."
	fi
}
