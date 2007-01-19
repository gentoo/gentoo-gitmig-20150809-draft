# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/ftpcube/ftpcube-0.5.1.ebuild,v 1.1 2007/01/19 10:58:01 lucass Exp $

inherit distutils

MY_P="${P/_beta/-b}"
DESCRIPTION="Graphical FTP client using wxPython"
SRC_URI="mirror://sourceforge/ftpcube/${MY_P}.tar.gz"
HOMEPAGE="http://ftpcube.sourceforge.net/"

KEYWORDS="~amd64 ~ppc ~x86"
SLOT="0"
LICENSE="Artistic"
IUSE="sftp"

DEPEND=">=dev-python/wxpython-2.6.3.3
	sftp? ( dev-python/paramiko )"

S="${WORKDIR}/${MY_P}"

src_install() {
	distutils_src_install --install-scripts=/usr/bin
}
