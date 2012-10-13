# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-irclib/python-irclib-3.2.2.ebuild,v 1.1 2012/10/13 05:25:20 patrick Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

DESCRIPTION="IRC client framework written in Python."
HOMEPAGE="http://python-irclib.sourceforge.net/"
#SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
SRC_URI="mirror://pypi/i/irc/irc-${PV}.zip"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

DEPEND=""
RDEPEND=""
RESTRICT="mirror"

S="${WORKDIR}/irc-${PV}"

src_install() {
	distutils_src_install

	if use doc; then
		# Examples are treated like real documentation
		insinto "/usr/share/doc/${PF}/examples"
		doins dccreceive dccsend irccat irccat2 servermap testbot.py
	fi
}
