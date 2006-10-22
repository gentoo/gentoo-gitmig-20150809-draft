# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/cdi/cdi-2.0.0.ebuild,v 1.2 2006/10/22 02:15:15 mr_bones_ Exp $

inherit elisp

IUSE=""

DESCRIPTION="Interface between Emacs and command-line CD players"
HOMEPAGE="https://alioth.debian.org/projects/mph-emacs-pkgs/
	http://www.emacswiki.org/cgi-bin/wiki.pl?action=browse&id=MattHodges&oldid=MatthewHodges"
SRC_URI="mirror://gentoo/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

RDEPEND="${DEPEND}
	media-sound/cdcd"

SITEFILE=50cdi-gentoo.el
