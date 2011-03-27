# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/getmail/getmail-4.17.0.ebuild,v 1.4 2011/03/27 14:42:40 klausman Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

DESCRIPTION="A POP3 mail retriever with reliable Maildir and mbox delivery"
HOMEPAGE="http://pyropus.ca/software/getmail/"
SRC_URI="http://pyropus.ca/software/getmail/old-versions/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="alpha amd64 ppc ~sparc ~x86 ~ppc-macos ~x86-macos ~x64-solaris"
IUSE=""

DEPEND=""
RDEPEND=""
RESTRICT_PYTHON_ABIS="3.*"

PYTHON_MODNAME="getmailcore"

src_prepare() {
	sed -i -e "s,'getmail-%s' % __version__,'${PF}'," \
		-e "/docs\/COPYING/d" "${S}"/setup.py || die
	distutils_src_prepare
}
