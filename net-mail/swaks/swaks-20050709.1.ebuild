# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/swaks/swaks-20050709.1.ebuild,v 1.4 2006/08/31 20:53:24 blubb Exp $

MY_P=${P/-/.}
DESCRIPTION="Swiss Army Knife SMTP; Command line SMTP testing, including TLS and AUTH"
HOMEPAGE="http://www.jetmore.org/john/code/#swaks"
SRC_URI="http://www.jetmore.org/john/code/${MY_P}"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"

IUSE="ssl"

DEPEND=">=dev-lang/perl-5.8.3"

RDEPEND="${DEPEND}
		>=dev-perl/Net-DNS-0.40
		ssl? ( >=dev-perl/Net-SSLeay-1.23 )
		>=virtual/perl-MIME-Base64-3.00
		>=virtual/perl-Digest-MD5-2.33
		>=virtual/perl-Time-HiRes-1.54
		>=dev-perl/Authen-NTLM-1.02
		>=dev-perl/Authen-DigestMD5-0.04"

S=${WORKDIR}

src_unpack() {
	cp ${DISTDIR}/${A} ${WORKDIR}
}

src_install() {
	newbin ${MY_P} swaks
}

