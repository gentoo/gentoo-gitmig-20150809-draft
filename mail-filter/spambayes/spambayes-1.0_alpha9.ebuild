# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-filter/spambayes/spambayes-1.0_alpha9.ebuild,v 1.1 2004/06/03 07:31:37 seemant Exp $

inherit distutils

#MY_PN="Quotient"
MY_PV=${PV/_alpha/a}
MY_P="${PN}-${MY_PV}"
DESCRIPTION="An anti-spam filter using on Bayesian filtering"
HOMEPAGE="http://spambayes.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=dev-lang/python-2.2.2"

S=${WORKDIR}/${MY_P}

