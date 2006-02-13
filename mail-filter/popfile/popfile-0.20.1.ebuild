# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-filter/popfile/popfile-0.20.1.ebuild,v 1.6 2006/02/13 14:34:23 mcummings Exp $

IUSE=""

S=${WORKDIR}
DESCRIPTION="Anti-spam filter"
HOMEPAGE="http://foo.bar.com/"
SRC_URI="mirror://sourceforge/popfile/${P}.zip"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND=">=dev-lang/perl-5.8
	>=dev-perl/BerkeleyDB-0.25
	dev-perl/Text-Kakasi
	virtual/perl-MIME-Base64
	dev-perl/HTML-Tagset
	app-arch/unzip"


src_compile() {
	# do nothing
	echo > /dev/null
}

src_install() {
	# yes, this is crude, but it's a start

	dodir /usr/share/popfile
	find . -type f -print | xargs chmod 600
	find . -type d -print | xargs chmod 700
	tar -cf - * | ( cd ${D}/usr/share/popfile && tar -xf - )

	fperms 0755 usr/share/popfile/popfile.pl
	dodir /usr/share/popfile/corpus
	dodir /usr/share/popfile/messages
}

pkg_postinst () {
	einfo "To start popfile, run /usr/share/popfile/popfile.pl"
	einfo
	einfo "A /etc/init.d script will be added once popfile can support"
	einfo "multiple users"
}
