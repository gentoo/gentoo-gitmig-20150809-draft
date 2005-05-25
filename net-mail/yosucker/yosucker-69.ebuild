# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/yosucker/yosucker-69.ebuild,v 1.5 2005/05/25 14:27:34 mcummings Exp $

inherit eutils

MY_P="YoSucker-pr${PV}"
S=${WORKDIR}/${MY_P}
IUSE=""
DESCRIPTION="Perl script that downloads mail from a Yahoo! webmail account to a local mail spool, an mbox file, or to procmail."
SRC_URI="mirror://sourceforge/yosucker/${MY_P}.tar.gz"
HOMEPAGE="http://yosucker.sourceforge.net"
LICENSE="GPL-2"
KEYWORDS="x86 ~amd64 ppc"

SLOT="0"

DEPEND="dev-lang/perl
		dev-perl/TermReadKey
		perl-core/Digest-MD5
		dev-perl/IO-Socket-SSL
		perl-core/MIME-Base64"

RDEPEND=""

src_install() {
	dobin bin/*
	mv utils/README utils/README.utils
	dodoc docs/*
	insinto /usr/share/doc/${P}/conf
	doins conf/*
	dolib lib/sputnik.pm

}

pkg_postinst() {
	draw_line
	ewarn "The Yahoo! Mail interface has changed!!"
	ewarn "you may need to log in to it manually before yosucker works again."
	draw_line
	ebeep 2
}
