# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-filter/spambayes/spambayes-1.0_rc1.ebuild,v 1.4 2005/02/24 19:27:30 sekretarz Exp $

inherit distutils

# Very obscure source package naming, spambayes-1.0b1.1.tar.gz
# replacing _beta with "b1." so file fetching will be correct.
MY_PV=${PV/_rc/rc}
MY_P="${PN}-${MY_PV}"
DESCRIPTION="An anti-spam filter using on Bayesian filtering"
HOMEPAGE="http://spambayes.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

RESTRICT="nomirror"

LICENSE="PSF-2.2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE=""

DEPEND=">=dev-lang/python-2.2.2"

# removing ".1" from the work directory name
S=${WORKDIR}/${MY_P/.1}

src_install() {
	distutils_src_install
	dodoc *.txt || die "doc *.txt files failed"
	# someone might have benefits of the other documetation too,
	# therefore added.
	docinto contrib || die "doc directory, contrib, fail"
	dodoc contrib/* || die "doc contrib/* failed"
	docinto utilities || die "doc directory, utilities, failed"
	dodoc utilities/* || die "doc utilities/* failed"
	docinto testtools || die "doc directory, testtools, failed"
	dodoc testtools/* || die "doc testtools/* failed"

	exeinto /etc/init.d
	newexe ${FILESDIR}/spambayespop3proxy.rc spambayespop3proxy

	insinto /etc
	doins ${FILESDIR}/bayescustomize.ini

	keepdir /var/lib/spambayes

}

