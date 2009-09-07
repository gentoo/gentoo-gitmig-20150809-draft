# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/papyon/papyon-0.4.1.ebuild,v 1.2 2009/09/07 19:56:25 klausman Exp $

inherit distutils

DESCRIPTION="Python MSN IM protocol implementation forked from pymsn"
HOMEPAGE="http://telepathy.freedesktop.org/"
SRC_URI="http://telepathy.freedesktop.org/releases/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~x86"
IUSE=""

DEPEND="dev-libs/libxslt"
RDEPEND=">=dev-lang/python-2.5
	>=dev-python/pygobject-2.10
	>=dev-python/pyopenssl-0.6
	>=dev-python/pycrypto-2.0"
