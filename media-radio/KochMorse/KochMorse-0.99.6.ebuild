# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-radio/KochMorse/KochMorse-0.99.6.ebuild,v 1.3 2010/10/05 20:48:22 maekke Exp $

EAPI=2

PYTHON_DEPEND="*"

inherit distutils python

DESCRIPTION="Morse-tutor for Linux using the Koch-method"
HOMEPAGE="http://KochMorse.googlecode.com/"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="dev-python/pyalsaaudio
	dev-python/pygtk"
