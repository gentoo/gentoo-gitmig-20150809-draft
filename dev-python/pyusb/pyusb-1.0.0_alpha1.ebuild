# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyusb/pyusb-1.0.0_alpha1.ebuild,v 1.1 2011/03/05 21:30:55 josejx Exp $

EAPI="2"
inherit distutils flag-o-matic

MY_P="${P/_alpha/-a}"
DESCRIPTION="USB support for Python."
HOMEPAGE="http://pyusb.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

### This version is compatible with both 0.X and 1.X versions of libusb
DEPEND="virtual/libusb:1"
RDEPEND="${DEPEND}"
PYTHON_DEPEND="*:2.5"

S="${WORKDIR}/${MY_P}"
