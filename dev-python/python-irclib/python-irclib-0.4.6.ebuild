# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-irclib/python-irclib-0.4.6.ebuild,v 1.3 2008/08/06 06:13:06 neurogeek Exp $

inherit distutils

DESCRIPTION="IRC client framework written in Python."
HOMEPAGE="http://python-irclib.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
RESTRICT="mirror"
LICENSE="LGPL-2.1"

SLOT="0"
KEYWORDS="~x86"
IUSE="doc"
DEPEND="virtual/python"

src_install() {
	distutils_src_install

	if use doc; then
		# Examples are treated like real documentation
		insinto "/usr/share/doc/${PF}/examples"
		doins dccreceive dccsend irccat irccat2 servermap testbot.py
	fi
}

