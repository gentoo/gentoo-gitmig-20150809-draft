# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/gentoo-init/gentoo-init-0.1.ebuild,v 1.8 2008/04/29 17:59:24 ranger Exp $

DESCRIPTION="Simple ASDF-BINARY-LOCATIONS configuration for Gentoo Common Lisp ports."
HOMEPAGE="http://www.gentoo.org/proj/en/lisp/common-lisp/guide.xml"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 sparc x86"
IUSE=""

S=${WORKDIR}

DEPEND="dev-lisp/cl-asdf-binary-locations"

src_install() {
	insinto /etc
	doins "${FILESDIR}"/gentoo-init.lisp
}
