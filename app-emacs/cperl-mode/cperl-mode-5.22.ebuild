# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/cperl-mode/cperl-mode-5.22.ebuild,v 1.1 2006/12/06 18:36:20 opfer Exp $

inherit elisp

DESCRIPTION="A more advanced mode for programming Perl than the default mode."
HOMEPAGE="http://www.emacswiki.org/cgi-bin/wiki/CPerlMode"
SRC_URI="http://math.berkeley.edu/~ilya/software/emacs/cperl-mode.el.${PV}.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc"
IUSE=""

SITEFILE="50cperl-mode-gentoo.el"

S=${WORKDIR}

src_unpack() {
	unpack ${A}
	cp ${S}/${PN}.el.${PV} ${S}/${PN}.el
}

