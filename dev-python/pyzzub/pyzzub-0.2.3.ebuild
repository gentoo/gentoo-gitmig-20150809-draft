# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyzzub/pyzzub-0.2.3.ebuild,v 1.1 2007/03/20 14:50:39 hanno Exp $

inherit distutils

DESCRIPTION="Python bindings for libzzub"
HOMEPAGE="http://trac.zeitherrschaft.org/zzub/"
SRC_URI="mirror://sourceforge/aldrin/libzzub-${PV}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

S=${WORKDIR}/libzzub-${PV}/src/${PN}/

DEPEND="media-libs/libzzub
	dev-python/ctypes"
