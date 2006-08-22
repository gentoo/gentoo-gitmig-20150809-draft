# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/supybot/supybot-0.77.2.ebuild,v 1.9 2006/08/22 09:57:03 liquidx Exp $

inherit distutils eutils

MY_P=${P/s/S}

DESCRIPTION="Python based extensible IRC infobot and channel bot"
HOMEPAGE="http://supybot.sf.net/"
SRC_URI="mirror://sourceforge/supybot/${MY_P}.tar.bz2
	mirror://gentoo/${P}-cvsadditions-2004-06-10.patch.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~ppc ppc-macos"
IUSE="sqlite"

DEPEND=">=dev-lang/python-2.3
	sqlite? ( <dev-python/pysqlite-1.99 )"

S=${WORKDIR}/${MY_P}

PYTHON_MODNAME="supybot"
DOCS="ACKS BUGS LICENSE TODO"

src_unpack() {
	unpack ${A}
	cd ${S}; epatch ${WORKDIR}/${P}-cvsadditions-2004-06-10.patch
}

src_install() {
	distutils_src_install
	dodoc examples/Random.py
	docinto developers
	dodoc docs/*
	docinto plugins
	dodoc docs/plugins/*
	exeinto /etc/init.d
	newexe ${FILESDIR}/supybot.rc supybot
	insinto /etc/conf.d
	newexe ${FILESDIR}/supybot.conf supybot
}

pkg_postinst() {
	einfo "Use supybot-wizard to create a configuration file"
}
