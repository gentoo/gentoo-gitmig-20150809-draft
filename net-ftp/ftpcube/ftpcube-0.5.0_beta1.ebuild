# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/ftpcube/ftpcube-0.5.0_beta1.ebuild,v 1.1 2006/12/29 12:59:59 dev-zero Exp $

inherit distutils eutils

KEYWORDS="~amd64 ~ppc ~x86"

MY_P=${P/_beta/-b}

DESCRIPTION="Graphical FTP client using wxPython"
SRC_URI="mirror://sourceforge/ftpcube/${MY_P}.tar.gz"
HOMEPAGE="http://ftpcube.sourceforge.net/"
SLOT="0"
LICENSE="Artistic"
IUSE="sftp"

DEPEND=">=dev-python/wxpython-2.6.3.3
	sftp? ( dev-python/paramiko )"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-transports.patch"
}

src_install() {
	distutils_src_install --install-scripts=/usr/bin
}
