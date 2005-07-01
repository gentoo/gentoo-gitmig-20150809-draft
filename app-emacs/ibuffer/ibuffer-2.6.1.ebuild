# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/ibuffer/ibuffer-2.6.1.ebuild,v 1.2 2005/07/01 18:47:37 mkennedy Exp $

inherit elisp

IUSE=""

# Rumor has it this package will be part of FSF GNU Emacs soon...

DESCRIPTION="Operate on buffers like dired"
HOMEPAGE="http://www.shootybangbang.com/"
# taken from http://www.shootybangbang.com/software/ibuffer.el
SRC_URI="mirror://gentoo/${P}.tar.bz2
	http://dev.gentoo.org/~usata/distfiles/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"

SITEFILE=50ibuffer-gentoo.el

