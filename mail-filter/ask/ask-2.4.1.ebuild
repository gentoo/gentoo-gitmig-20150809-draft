# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-filter/ask/ask-2.4.1.ebuild,v 1.3 2004/08/28 18:08:09 dholm Exp $

DESCRIPTION="Active Spam Killer: A program to filter spam"
HOMEPAGE="http://www.paganini.net/ask/index.html"
SRC_URI="mirror://sourceforge/a-s-k/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"

IUSE="procmail"
RDEPEND=">=dev-lang/python-2.2
		virtual/mta
		procmail? ( >=mail-filter/procmail-3.22 )"

src_install() {
	into /
	dobin ask.py asksetup.py askversion.py utils/asksenders.py

	insinto /usr/lib/ask
	doins askconfig.py asklock.py asklog.py askmail.py askmain.py \
		 askmessage.py askremote.py

	insinto /usr/share/ask/samples
	doins samples/*

	insinto /usr/share/ask/templates
	doins templates/*

	insinto /usr/share/ask/utils
	doins utils/*

	doman docs/*.1

	dodoc ChangeLog TODO docs/ask_doc*
}

pkg_postinst() {
	einfo
	einfo "You MUST run the asksetup.py file to configure ASK!"
	einfo
	if use procmail; then
		einfo "To use ASK's procmail support these should be your first two procmail rules:"
		einfo
		einfo ":0 fW"
		einfo "|/path_to_ask/ask.py --procmail --loglevel=5 --logfile=/your_home/ask.log"
		einfo
		einfo ":0 e"
		einfo "/dev/null"
		einfo
		einfo "The second rule above instructs procmail to deliver the message to /dev/null"
		einfo "if ASK returns a fail code. If you're truly paranoid, you can save those"
		einfo "messages to a file instead for later inspection."
	fi
}
