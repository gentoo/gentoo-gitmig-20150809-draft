# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/getmail/getmail-4.9.1.ebuild,v 1.8 2011/04/05 17:51:32 arfrever Exp $

EAPI="3"

inherit distutils

DESCRIPTION="A POP3 mail retriever with reliable Maildir and mbox delivery"
HOMEPAGE="http://pyropus.ca/software/getmail/"
SRC_URI="http://pyropus.ca/software/getmail/old-versions/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="alpha amd64 ppc sparc x86"
IUSE=""

DEPEND=">=dev-lang/python-2.3.3"
RDEPEND="${DEPEND}"

PYTHON_MODNAME=getmailcore

src_install() {
	distutils_src_install

	# handle docs the gentoo way
	rm "${D}"/usr/share/doc/${P}/COPYING
	if [ ${P} != ${PF} ]; then
		mv "${D}"/usr/share/doc/${P} "${D}"/usr/share/doc/${PF}
	fi

	dodir /usr/share/doc/${PF}/html
	mv "${D}"/usr/share/doc/${PF}/*.html "${D}"/usr/share/doc/${PF}/*.css "${D}"/usr/share/doc/${PF}/html
}
