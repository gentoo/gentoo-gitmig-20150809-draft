# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/onak/onak-0.3.3.ebuild,v 1.1 2007/05/22 15:43:29 alonbl Exp $

DESCRIPTION="onak is an OpenPGP keyserver"
HOMEPAGE="http://www.earth.li/projectpurple/progs/onak.html"
SRC_URI="http://www.earth.li/projectpurple/files/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
RDEPEND="=sys-libs/db-4*"
DEPEND="${RDEPEND}"

src_install() {
	keepdir /var/lib/onak
	dosbin onak maxpath sixdegrees onak-mail.pl
	dobin splitkeys stripkey
	doman *.[1-8]
	insinto /etc
	doins onak.conf

	# these are CGI stuff that I don't want to deal with yet
	#dobin lookup add gpgwww
	sed -i \
	-e 's,^www_port 11371,www_port 0,g' \
	-e 's,^db_dir /var/lib/lib/onak,db_dir /var/lib/onak,g' \
	-e 's,^logfile /var/lib/log/onak.log,logfile /var/log/onak.log,g' \
	-e 's,^max_last 1,max_last 0,g' \
	${D}/etc/onak.conf
}
