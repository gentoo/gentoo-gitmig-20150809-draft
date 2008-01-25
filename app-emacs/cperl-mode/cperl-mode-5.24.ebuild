# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/cperl-mode/cperl-mode-5.24.ebuild,v 1.1 2008/01/25 11:54:31 opfer Exp $

inherit elisp

DESCRIPTION="An advanced mode for programming Perl"
HOMEPAGE="http://www.emacswiki.org/cgi-bin/wiki/CPerlMode"
SRC_URI="http://math.berkeley.edu/~ilya/software/emacs/cperl-mode.el.${PV}.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

SITEFILE="50cperl-mode-gentoo.el"

S=${WORKDIR}

src_unpack() {
	unpack ${A}
	cp "${S}/${PN}.el.${PV}" "${S}/${PN}.el"
}
