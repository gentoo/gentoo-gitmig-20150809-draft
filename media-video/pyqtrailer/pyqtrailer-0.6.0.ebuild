# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/pyqtrailer/pyqtrailer-0.6.0.ebuild,v 1.1 2010/11/28 19:06:36 sochotnicky Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS=""

inherit distutils

DESCRIPTION="Qt4 application for downloading trailers from apple.com"
HOMEPAGE="http://github.com/sochotnicky/pyqtrailer http://pypi.python.org/pypi/pyqtrailer"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-python/pytrailer-0.6.0
		dev-python/PyQt4
		dev-python/python-dateutil"
RDEPEND="$DEPEND"

src_install()
{
	distutils_src_install

	insinto /usr/share/pixmaps
	newins xdg/${PN}.svg ${PN}.svg || die

	insinto /usr/share/applications
	doins "xdg/${PN}.desktop" || die
}
