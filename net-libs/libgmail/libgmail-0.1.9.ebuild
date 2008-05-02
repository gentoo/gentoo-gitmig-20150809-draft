# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libgmail/libgmail-0.1.9.ebuild,v 1.1 2008/05/02 16:16:37 armin76 Exp $

inherit distutils

DESCRIPTION="Python bindings to access Google's gmail service"
HOMEPAGE="http://libgmail.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~x86"

IUSE=""
DEPEND="dev-python/clientcookie"
