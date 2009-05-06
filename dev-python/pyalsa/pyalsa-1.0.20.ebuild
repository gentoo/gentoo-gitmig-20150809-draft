# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyalsa/pyalsa-1.0.20.ebuild,v 1.1 2009/05/06 18:07:40 beandog Exp $

inherit distutils

DESCRIPTION="Python Bindings for Alsa lib"
HOMEPAGE="http://alsa-project.org/"
SRC_URI="mirror://alsaproject/pyalsa/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="media-libs/alsa-lib"

src_install() {
	distutils_src_install
}
