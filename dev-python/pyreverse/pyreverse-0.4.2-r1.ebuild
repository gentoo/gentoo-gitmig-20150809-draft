# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyreverse/pyreverse-0.4.2-r1.ebuild,v 1.2 2004/08/03 12:05:43 dholm Exp $

inherit distutils

DESCRIPTION="Tools for analysing dependencies, generating documentation and XMI generation for importing into UML modelling tools."
SRC_URI="ftp://ftp.logilab.org/pub/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.logilab.org/projects/pyreverse/"

SLOT="0"
IUSE=""
KEYWORDS="~x86 ~ppc"
LICENSE="GPL-2"
DEPEND="virtual/python"
RDEPEND="${DEPEND}
	dev-python/optik
	dev-python/logilab-common
	dev-python/pyxml"

