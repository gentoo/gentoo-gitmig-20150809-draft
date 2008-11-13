# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/synce-pywbxml/synce-pywbxml-0.1.ebuild,v 1.1 2008/11/13 06:37:54 mescalinum Exp $

inherit eutils

DESCRIPTION="SynCE - Python bindings for libwbxml"
HOMEPAGE="http://sourceforge.net/projects/synce/"
LICENSE="MIT"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
DEPEND="dev-lang/python
		dev-python/pyrex
		=dev-libs/libwbxml-0.9.2_p48"

MY_P="pywbxml-${PV}"
SRC_URI="mirror://sourceforge/synce/${MY_P}.tar.gz"

S="${WORKDIR}/${MY_P}"
