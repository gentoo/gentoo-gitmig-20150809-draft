# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/ftpcube/ftpcube-0.5.1-r1.ebuild,v 1.4 2010/02/08 09:02:41 pva Exp $

inherit eutils distutils

MY_P="${P/_beta/-b}"
DESCRIPTION="Graphical FTP client using wxPython"
SRC_URI="mirror://sourceforge/ftpcube/${MY_P}.tar.gz"
HOMEPAGE="http://ftpcube.sourceforge.net/"

KEYWORDS="~amd64 hppa ~ppc sparc x86"
SLOT="0"
LICENSE="Artistic"
IUSE="sftp"

DEPEND="=dev-python/wxpython-2.6*
	sftp? ( dev-python/paramiko )"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	distutils_src_unpack
	epatch "${FILESDIR}/${P}-wxversion.patch"
}

src_install() {
	distutils_src_install --install-scripts=/usr/bin
}
