# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/yosucker/yosucker-29.ebuild,v 1.1 2003/06/29 07:20:37 andrd Exp $

MY_P="YoSucker-pr${PV}"
S=${WORKDIR}/${MY_P}
IUSE=""
DESCRIPTION="Perl script that downloads mail from a Yahoo! webmail account to a local mail spool, an mbox file, or to procmail."
SRC_URI="mirror://sourceforge/yosucker/${MY_P}.tar.gz"
HOMEPAGE="http://yosucker.sourceforge.net"
LICENSE="GPL-2"
KEYWORDS="~x86"

SLOT="0"

DEPEND="dev-lang/perl
		dev-perl/TermReadKey
		dev-perl/Digest-MD5
		dev-perl/IO-Socket-SSL
		dev-perl/MIME-Base64"

RDEPEND=""

src_install() {
	dobin bin/EncPasswd bin/EncProxyPasswd bin/YoSucker utils/YoDaemon utils/YoPop
	mv utils/README utils/README.utils
	dodoc docs/ChangeLog docs/Configuration docs/Credits docs/FAQ docs/FastCheck docs/Migration docs/TODO docs/Tuning utils/README.utils
	insinto /usr/share/doc/${P}/conf
	doins conf/README conf/header-translation conf/sample1.conf conf/sample2.conf conf/sample3-procmail.conf conf/sample4-proxy.conf
	dolib lib/haiku.pm lib/sputnik.pm
}

