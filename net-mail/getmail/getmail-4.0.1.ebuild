# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/getmail/getmail-4.0.1.ebuild,v 1.1 2004/07/30 15:59:15 langthang Exp $

inherit distutils
IUSE=""
DESCRIPTION="A POP3 mail retriever with reliable Maildir and mbox delivery"
HOMEPAGE="http://www.qcc.ca/~charlesc/software/getmail-4/"
SRC_URI="http://www.qcc.ca/~charlesc/software/getmail-4/${P}.tar.gz"

SLOT="4"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~amd64"

DEPEND=">=dev-lang/python-2.3.3"

warn() {
	echo
	ewarn "getmail version 4 has been completely rewritten. Visit:"
	echo "http://www.qcc.ca/~charlesc/software/getmail-4/documentation.html#v4differences"
	ewarn "for changes it might affect you upgrading from getmail version 3."
	echo
	ewarn "This version has been SLOTTED to co-exist with getmail 3."
	ewarn "The three main scripts are getmail4, getmail_maildir4, getmail_mbox4."
	ewarn "Please remember to \`env-update; source /etc/profile\` before the first use."
	echo
	ewarn "Waiting 15 seconds before continuing..."
	sleep 15
}

pkg_setup() {
	warn
}

src_compile() {
	distutils_src_compile
}

src_install() {
	LIBPATH=${ROOT}/usr/lib/${P}
	echo "PYTHONPATH=\"${LIBPATH}\"" > 99${P}
	insinto ${ROOT}/etc/env.d
	doins 99${P}
	python setup.py install --install-scripts=${D}/usr/bin/ \
		--install-data=${D}/usr/share/ --install-lib=${D}/usr/lib/${P}/
	mv ${D}/usr/bin/getmail ${D}/usr/bin/getmail4
	mv ${D}/usr/bin/getmail_maildir ${D}/usr/bin/getmail_maildir4
	mv ${D}/usr/bin/getmail_mbox ${D}/usr/bin/getmail_mbox4
}

pkg_postinst() {
	warn
}
