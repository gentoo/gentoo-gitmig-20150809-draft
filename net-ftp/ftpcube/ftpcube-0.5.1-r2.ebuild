# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/ftpcube/ftpcube-0.5.1-r2.ebuild,v 1.2 2011/09/13 05:42:28 floppym Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils eutils

DESCRIPTION="Graphical FTP client using wxPython"
SRC_URI="mirror://sourceforge/ftpcube/${P}.tar.gz"
HOMEPAGE="http://ftpcube.sourceforge.net/"

KEYWORDS="~amd64 ~hppa ~ppc ~sparc ~x86"
SLOT="0"
LICENSE="Artistic"
IUSE="sftp"

DEPEND="=dev-python/wxpython-2.6*
	sftp? ( dev-python/paramiko )"
RDEPEND="${DEPEND}"
RESTRICT_PYTHON_ABIS="3.*"

PYTHON_MODNAME="libftpcube"

src_prepare() {
	distutils_src_prepare
	epatch "${FILESDIR}/${P}-wxversion.patch"

	# setup.cfg specifies /usr/local location for data and scripts.
	rm setup.cfg || die
}

src_install() {
	distutils_src_install
	doicon "${FILESDIR}"/${PN}.xpm || die
	make_desktop_entry ${PN} FtpCube ${PN}
}
