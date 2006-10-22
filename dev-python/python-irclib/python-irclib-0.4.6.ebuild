# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-irclib/python-irclib-0.4.6.ebuild,v 1.1 2006/10/22 20:28:52 radek Exp $

inherit distutils

DESCRIPTION="IRC client framework written in Python."
HOMEPAGE="http://python-irclib.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
RESTRICT="nomirror"
LICENSE="LGPL-2.1"

SLOT="0"
KEYWORDS="~x86"
IUSE="doc"
DEPEND="dev-lang/python"

src_install() {

	python_version
	insinto /usr/lib/python${PYVER}/site-packages/
	doins ircbot.py irclib.py

	# this is installed even without doc flag, because, its small
	dodoc README ChangeLog

	if use doc ; then
		# Examples are treated like real documentation
		dodir /usr/share/doc/${P}/examples
		insinto /usr/share/doc/${P}/examples
		doins dccreceive dccsend irccat irccat2 servermap testbot.py
	fi
}
