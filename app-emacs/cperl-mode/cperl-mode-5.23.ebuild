# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/cperl-mode/cperl-mode-5.23.ebuild,v 1.1 2007/10/07 20:47:10 opfer Exp $

inherit elisp

DESCRIPTION="A more advanced mode for programming Perl than the default mode."
HOMEPAGE="http://www.emacswiki.org/cgi-bin/wiki/CPerlMode"
SRC_URI="http://math.berkeley.edu/~ilya/software/emacs/cperl-mode.el-${PV}.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

SITEFILE="50cperl-mode-gentoo.el"

S=${WORKDIR}

src_unpack() {
	unpack ${A}
	cp "${S}/${PN}.el-${PV}" "${S}/${PN}.el"
}
