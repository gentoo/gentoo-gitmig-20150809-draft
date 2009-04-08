# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/company-mode/company-mode-0.2.1.ebuild,v 1.1 2009/04/08 16:20:59 ulm Exp $

EAPI=2
NEED_EMACS=22

inherit elisp

DESCRIPTION="In-buffer completion front-end"
HOMEPAGE="http://nschum.de/src/emacs/company-mode/"
SRC_URI="http://nschum.de/src/emacs/${PN}/company-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="semantic"

DEPEND="semantic? ( app-emacs/cedet )"
	#oddmuse? ( app-emacs/oddmuse )
RDEPEND="${DEPEND}"

S="${WORKDIR}"
SITEFILE="50${PN}-gentoo.el"

src_configure() {
	# Disable backends that require extra dependencies, unless they are
	# selected by the respective USE flag
	local backend
	for backend in oddmuse semantic; do
		[ "${backend}" = semantic ] && use "${backend}" && continue
		elog "Disabling ${backend} backend"
		rm "company-${backend}.el" || die
		sed -i -e "s/company-${backend} *//" company.el || die
	done
}
