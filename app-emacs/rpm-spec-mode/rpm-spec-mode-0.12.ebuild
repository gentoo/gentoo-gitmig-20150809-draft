# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/rpm-spec-mode/rpm-spec-mode-0.12.ebuild,v 1.1 2012/02/19 14:59:15 sochotnicky Exp $

inherit elisp

DESCRIPTION="Emacs mode to ease eiditing of RPM spec files"
HOMEPAGE="http://www.emacswiki.org/emacs/RpmSpecMode"
SRC_URI="http://dev.gentoo.org/${P}.el"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

SITEFILE="50${PN}-gentoo.el"

src_unpack() {
		cp "${DISTDIR}"/${P}.el "${WORKDIR}"/${PN}.el
}
