# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-filter/spambayes/spambayes-1.0_beta1.ebuild,v 1.1 2004/06/03 07:31:37 seemant Exp $

inherit distutils

# Very obscure source package naming, spambayes-1.0b1.1.tar.gz
# replacing _beta with "b1." so file fetching will be correct.
MY_PV=${PV/_beta/b1.}
MY_P="${PN}-${MY_PV}"
DESCRIPTION="An anti-spam filter using on Bayesian filtering"
HOMEPAGE="http://spambayes.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

RESTRICT="nomirror"

LICENSE="PSF-2.2"
SLOT="0"
KEYWORDS="~x86"
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
}

