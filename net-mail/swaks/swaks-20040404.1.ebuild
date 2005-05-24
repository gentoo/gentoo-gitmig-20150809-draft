# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/swaks/swaks-20040404.1.ebuild,v 1.2 2005/05/24 15:58:53 mcummings Exp $

MY_P=${P/-/.}
DESCRIPTION="Swiss Army Knife SMTP; Command line SMTP testing, including TLS and AUTH"
HOMEPAGE="http://www.jetmore.org/john/code/#swaks"
SRC_URI="http://www.jetmore.org/john/code/${MY_P}"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

IUSE="ssl"

DEPEND=">=dev-lang/perl-5.8.3"

RDEPEND="${DEPEND}
		>=dev-perl/Net-DNS-0.40
		ssl? ( >=dev-perl/Net-SSLeay-1.23 )
		>=dev-perl/MIME-Base64-3.00
		>=perl-core/Digest-MD5-2.33
		>=dev-perl/Time-HiRes-1.54
		>=dev-perl/Authen-NTLM-1.02
		>=dev-perl/Authen-DigestMD5-0.04"

S=${WORKDIR}

src_unpack() {
	cp ${DISTDIR}/${A} ${WORKDIR}
}

src_install() {
	newbin ${MY_P} swaks
}

