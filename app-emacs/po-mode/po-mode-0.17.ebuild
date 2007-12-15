# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/po-mode/po-mode-0.17.ebuild,v 1.3 2007/12/15 08:12:28 drac Exp $

inherit elisp

DESCRIPTION="Major mode for GNU gettext PO files"
HOMEPAGE="http://www.gnu.org/software/gettext/"
SRC_URI="mirror://gnu/gettext/gettext-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ppc ~ppc64 ~s390 ~sh ~sparc ~sparc-fbsd ~x86 ~x86-fbsd"
IUSE=""

S="${WORKDIR}/gettext-${PV}/gettext-tools/misc"
SITEFILE=51${PN}-gentoo.el

src_compile() {
	elisp-compile po-mode.el po-compat.el || die "elisp-compile failed"
}
