# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/papyon/papyon-0.5.1-r1.ebuild,v 1.1 2010/10/21 02:27:58 jmbsvicetto Exp $

EAPI=2

inherit distutils eutils

DESCRIPTION="Python MSN IM protocol implementation forked from pymsn"
HOMEPAGE="http://www.freedesktop.org/wiki/Software/papyon"
SRC_URI="http://www.freedesktop.org/software/${PN}/releases/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND=">=dev-lang/python-2.5
	>=dev-python/pygobject-2.10
	>=dev-python/pyopenssl-0.6
	dev-python/gst-python
	dev-python/pycrypto
	net-libs/farsight2[python]"
DEPEND="${RDEPEND}"

src_prepare() {
	# Apply upstream patch to fix connection to the contacts server
	# https://bugs.freedesktop.org/show_bug.cgi?id=31004
	# https://bugs.freedesktop.org/attachment.cgi?id=39599
	epatch "${FILESDIR}/${P}-contacts-fix.patch" || die "Failed to apply patch."

	distutils_src_prepare
}
