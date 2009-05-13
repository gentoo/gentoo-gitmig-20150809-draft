# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/clive/clive-2.1.12.ebuild,v 1.1 2009/05/13 18:54:27 aballier Exp $

DESCRIPTION="Command line tool for extracting videos from various websites"
HOMEPAGE="http://clive.sourceforge.net/"
SRC_URI="http://clive.googlecode.com/files/${P}.tar.bz2"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="clipboard pager password"

RDEPEND=">=dev-lang/perl-5.8
	>=dev-perl/BerkeleyDB-0.34
	>=dev-perl/Config-Tiny-2.12
	>=virtual/perl-Digest-SHA-5.47
	>=dev-perl/HTML-TokeParser-Simple-2.37
	>=dev-perl/WWW-Curl-4.05
	>=dev-perl/XML-Simple-2.18
	virtual/perl-Getopt-Long
	virtual/perl-File-Spec
	clipboard? ( >=dev-perl/Clipboard-0.09 )
	pager? ( >=dev-perl/IO-Pager-0.05 )
	password? ( >=dev-perl/Expect-1.21 )"
DEPEND=""

src_install() {
	emake prefix=/usr DESTDIR="${D}" install || die
	dodoc AUTHORS CHANGES
}
