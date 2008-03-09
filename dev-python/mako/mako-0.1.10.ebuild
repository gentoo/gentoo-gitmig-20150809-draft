# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/mako/mako-0.1.10.ebuild,v 1.1 2008/03/09 08:52:27 antarus Exp $

inherit distutils

DESCRIPTION="A python templating language."
HOMEPAGE="http://www.makotemplates.org/"
SRC_URI="http://www.makotemplates.org/downloads/Mako-0.1.10.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND=""
S="${WORKDIR}/Mako-${PV}"
