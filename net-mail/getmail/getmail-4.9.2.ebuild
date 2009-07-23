# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/getmail/getmail-4.9.2.ebuild,v 1.1 2009/07/23 19:27:29 tove Exp $

inherit distutils

DESCRIPTION="A POP3 mail retriever with reliable Maildir and mbox delivery"
HOMEPAGE="http://pyropus.ca/software/getmail/"
SRC_URI="http://pyropus.ca/software/getmail/old-versions/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND=">=dev-lang/python-2.3.3"
RDEPEND="${DEPEND}"

PYTHON_MODNAME=getmailcore

src_install() {
	distutils_src_install

	# handle docs the gentoo way
	rm "${D}"/usr/share/doc/${P}/COPYING || die
	if [[ ${P} != ${PF} ]] ; then
		mv "${D}"/usr/share/doc/${P} "${D}"/usr/share/doc/${PF} || die
	fi

	dodir /usr/share/doc/${PF}/html
	mv "${D}"/usr/share/doc/${PF}/*.{html,css} "${D}"/usr/share/doc/${PF}/html || die
}
