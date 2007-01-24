# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-filter/spambayes/spambayes-1.1_alpha3.ebuild,v 1.1 2007/01/24 11:49:17 dev-zero Exp $

inherit distutils

MY_P=${P/_alpha/a}

DESCRIPTION="An anti-spam filter using on Bayesian filtering"
HOMEPAGE="http://spambayes.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="PSF-2.2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE=""

DEPEND=">=dev-lang/python-2.2.2"

S=${WORKDIR}/${MY_P}

src_install() {
	distutils_src_install
	dodoc *.txt
	insinto /usr/share/doc/${PF}/contrib
	doins contrib/*
	insinto /usr/share/doc/${PF}/utilities
	doins utilities/*
	insinto /usr/share/doc/${PF}/testtools
	doins testtools/*

	exeinto /etc/init.d
	newexe ${FILESDIR}/spambayespop3proxy.rc spambayespop3proxy

	insinto /etc
	doins ${FILESDIR}/bayescustomize.ini

	keepdir /var/lib/spambayes

}

