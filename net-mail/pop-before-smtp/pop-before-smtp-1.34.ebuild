# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/pop-before-smtp/pop-before-smtp-1.34.ebuild,v 1.1 2004/02/05 12:37:19 aliz Exp $

DESCRIPTION="This is a sample skeleton ebuild file"
HOMEPAGE="http://popbsmtp.sourceforge.net"
SRC_URI="mirror://sourceforge/popbsmtp/${P}.tar.gz"
LICENSE="GPL-2 BSD Artistic"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="X gnome"
DEPEND="dev-perl/File-Tail
	dev-perl/Time-HiRes
	dev-perl/Net-Netmask
	dev-perl/TimeDate
	dev-perl/Unix-Syslog"
#RDEPEND=""
S=${WORKDIR}/${P}

src_unpack() {
	unpack ${A} ; cd ${S}

	# enable syslog
	sed -i -e "/^=cut #============================= syslog ===========================START=$/d" \
		-e "/^=cut #============================= syslog =============================END=$/d" \
		pop-before-smtp-conf.pl
}

src_install() {
	dosbin pop-before-smtp

	dodoc README ChangeLog TODO contrib/README.QUICKSTART

	insinto /etc ; doins pop-before-smtp-conf.pl

	exeinto /etc/init.d
	newexe ${FILESDIR}/pop-before-smtp.init pop-before.smtp
}
