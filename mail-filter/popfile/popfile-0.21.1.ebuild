# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-filter/popfile/popfile-0.21.1.ebuild,v 1.5 2005/05/24 15:56:00 mcummings Exp $

IUSE=""

S=${WORKDIR}
DESCRIPTION="Anti-spam bayesian filter"
HOMEPAGE="http://popfile.sourceforge.net/"
SRC_URI="mirror://sourceforge/popfile/${P}.zip"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"

DEPEND=">=dev-lang/perl-5.8
	perl-core/Digest-MD5
	dev-perl/Text-Kakasi
	dev-perl/MIME-Base64
	dev-perl/HTML-Tagset
	dev-perl/DBD-SQLite
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
