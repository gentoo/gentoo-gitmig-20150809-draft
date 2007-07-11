# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyreverse/pyreverse-0.4.2-r1.ebuild,v 1.5 2007/07/11 06:19:47 mr_bones_ Exp $

inherit distutils

DESCRIPTION="Tools for analysing dependencies, generating documentation and XMI generation for importing into UML modelling tools."
SRC_URI="ftp://ftp.logilab.org/pub/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.logilab.org/projects/pyreverse/"

SLOT="0"
IUSE=""
KEYWORDS="~ppc ~sparc x86"
LICENSE="GPL-2"
DEPEND="virtual/python"
RDEPEND="${DEPEND}
	dev-python/optik
	dev-python/logilab-common
	dev-python/pyxml"
