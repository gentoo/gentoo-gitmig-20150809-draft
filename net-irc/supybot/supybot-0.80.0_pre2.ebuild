# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/supybot/supybot-0.80.0_pre2.ebuild,v 1.1 2004/10/26 09:54:51 liquidx Exp $

inherit distutils eutils

MY_P=${P/supybot/Supybot}
MY_P=${MY_P/_pre/pre}

DESCRIPTION="Python based extensible IRC infobot and channel bot"
HOMEPAGE="http://supybot.sf.net/"
SRC_URI="mirror://sourceforge/supybot/${MY_P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~ppc ~ppc-macos"
IUSE="sqlite"

DEPEND=">=dev-lang/python-2.3
	sqlite? ( >=dev-python/pysqlite-0.4.3 )"

S=${WORKDIR}/${MY_P}

PYTHON_MODNAME="supybot"
DOCS="ACKS BUGS LICENSE TODO"

src_install() {
	distutils_src_install
	dodoc examples/Random.py
	docinto developers
	dodoc docs/*
	docinto plugins
	dodoc docs/plugins/*
}

pkg_postinst() {
	einfo "Use supybot-wizard to create a configuration file"
	use sqlite || \
		einfo "Some plugins require may dev-python/pysqlite to function."
}
