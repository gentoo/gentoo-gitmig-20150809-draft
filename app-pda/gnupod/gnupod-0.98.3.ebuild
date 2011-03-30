# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/gnupod/gnupod-0.98.3.ebuild,v 1.4 2011/03/30 15:00:00 ssuominen Exp $

inherit perl-module

DESCRIPTION="A collection of Perl-scripts for iPod"
HOMEPAGE="http://www.gnu.org/software/gnupod/"
SRC_URI="http://blinkenlights.ch/gnupod-dist/stable/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86"
IUSE=""

# perl-5.8.0 contains Getopt-Long and Digest-MD5.
DEPEND="dev-lang/perl
	dev-perl/MP3-Info
	dev-perl/XML-Parser
	dev-perl/Unicode-String
	|| ( >=dev-lang/perl-5.8.0
		( virtual/perl-Getopt-Long
		virtual/perl-Digest-MD5
		)
	)"
RDEPEND="${DEPEND}"

src_compile() {
	econf
}

src_install() {
	perlinfo
	sed -i -e "s:\$INC\[0\]/\$modi:${D}${VENDOR_ARCH}/\$modi:g" \
		tools/gnupod_install.pl || die

	dodir /usr/bin
	dodir ${VENDOR_ARCH}/GNUpod
	dodir /usr/share/info
	einstall || die

	dodoc AUTHORS BUGS CHANGES README* TODO doc/gnutunesdb.example
	dohtml doc/gnupod.html
}
