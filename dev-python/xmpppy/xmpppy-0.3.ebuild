# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/xmpppy/xmpppy-0.3.ebuild,v 1.1 2006/03/20 00:51:08 sbriesen Exp $

inherit eutils distutils portability

MY_P="${P/_/-}"

DESCRIPTION="python library that is targeted to provide easy scripting with Jabber"
HOMEPAGE="http://xmpppy.sourceforge.net/"
SRC_URI="mirror://sourceforge/xmpppy/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="doc"

S="${WORKDIR}/${MY_P}"

DEPEND="virtual/python"

PYTHON_MODNAME="xmpp"

src_install(){
	distutils_src_install
	if use doc; then
		cd doc && treecopy . "${D}/usr/share/doc/${PF}/html"
	fi
}
