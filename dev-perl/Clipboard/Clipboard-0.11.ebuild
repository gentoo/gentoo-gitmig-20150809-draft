# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Clipboard/Clipboard-0.11.ebuild,v 1.1 2010/10/09 08:30:15 tove Exp $

EAPI=2

MODULE_AUTHOR=KING
inherit perl-module

DESCRIPTION="Copy and paste with any OS"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

RDEPEND="x11-misc/xclip"
