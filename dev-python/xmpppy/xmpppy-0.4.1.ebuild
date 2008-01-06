# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/xmpppy/xmpppy-0.4.1.ebuild,v 1.1 2008/01/06 03:04:21 sbriesen Exp $

inherit eutils distutils

MY_P="${P/_/-}"

DESCRIPTION="python library that is targeted to provide easy scripting with Jabber"
HOMEPAGE="http://xmpppy.sourceforge.net/"
SRC_URI="mirror://sourceforge/xmpppy/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~x86"
IUSE="doc"

RDEPEND="${DEPEND}
	|| (
		dev-python/dnspython
		dev-python/pydns
	)"

S="${WORKDIR}/${MY_P}"

PYTHON_MODNAME="xmpp"

src_install(){
	distutils_src_install
	use doc && dohtml -A py -r doc/.
}
