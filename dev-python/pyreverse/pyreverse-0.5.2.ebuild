# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyreverse/pyreverse-0.5.2.ebuild,v 1.1 2009/04/23 23:12:39 arfrever Exp $

EAPI="2"

inherit distutils

DESCRIPTION="Tools for analysing dependencies, generating documentation and XMI generation for importing into UML modelling tools."
SRC_URI="ftp://ftp.logilab.org/pub/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.logilab.org/projects/pyreverse/"

SLOT="0"
IUSE=""
KEYWORDS="~amd64 ~ia64 ~ppc ~sparc ~x86"
LICENSE="GPL-2"
DEPEND="dev-lang/python"
RDEPEND="${DEPEND}
	dev-python/optik
	>=dev-python/logilab-common-0.10.0
	dev-python/pyxml"

src_prepare() {
	sed -e '/^__revision__[[:space:]]*=/{h;d};/^from __future__ import/G' -i setup.py || die "sed setup.py failed"
}
