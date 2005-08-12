# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/metasploit/metasploit-2.4-r1.ebuild,v 1.3 2005/08/12 00:11:44 tester Exp $

MY_P="${P/metasploit/framework}"
S="${WORKDIR}/${MY_P}"
DESCRIPTION="The Metasploit Framework is an advanced open-source platform for developing, testing, and using vulnerability exploit code."
HOMEPAGE="http://www.metasploit.org/"
SRC_URI="http://metasploit.com/tools/${MY_P}.tar.gz"

LICENSE="GPL-2 Artistic"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="dev-lang/perl
	 dev-perl/Net-SSLeay
	 dev-perl/Term-ReadLine-Perl
	 dev-perl/TermReadKey"

src_install() {
	dodir /usr/lib/
	dodir /usr/bin/

	# should be as simple as copying everything into the target...
	cp -a ${S} ${D}usr/lib/metasploit || die

	# and creating symlinks in the /usr/bin dir
	cd ${D}/usr/bin
	ln -s ../lib/metasploit/msf* ./ || die
	chown -R root:root ${D}

	newinitd ${FILESDIR}/msfweb.initd msfweb || die "newinitd failed"
	newconfd ${FILESDIR}/msfweb.confd msfweb || die "newconfd failed"
}

pkg_postinst() {
	ewarn "You may wish to perform a metasploit update to get"
	ewarn "the latest modules (e.g. run 'msfupdate -u')"
}
