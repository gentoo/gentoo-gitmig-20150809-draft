# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/zopeedit/zopeedit-0.9.1.ebuild,v 1.5 2011/04/06 13:51:34 arfrever Exp $

# TODO: Add net-zope/collective-zopeedit and delete net-zope/zopeedit.
# http://pypi.python.org/pypi/collective.zopeedit

EAPI="3"

inherit distutils

DESCRIPTION="Configurable helper application that drop you into your favorite editor(s) directly from the ZMI"
HOMEPAGE="http://plope.com/software/ExternalEditor/"
SRC_URI="http://plope.com/software/ExternalEditor/zopeedit-${PV}-src.tgz"

LICENSE="ZPL"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

#S=${WORKDIR}/${PN}-${PV}-src

pkg_postinst() {
	einfo "Please consider emerging also externaleditor zope product"
	einfo "Complete help available at: http://plope.com/software/ExternalEditor/install-unix/"
}
