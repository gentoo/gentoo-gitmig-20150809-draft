# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/php-mode/php-mode-1.2.0.ebuild,v 1.5 2007/10/09 14:47:01 pylon Exp $

inherit elisp

DESCRIPTION="GNU Emacs major mode for editing PHP code"
HOMEPAGE="http://php-mode.sourceforge.net"
SRC_URI="mirror://sourceforge/php-mode/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc ~ppc64 x86 ~x86-fbsd"
IUSE=""

S="${WORKDIR}"

SITEFILE=51${PN}-gentoo.el
