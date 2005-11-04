# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-filter/spambayes/spambayes-1.0.4.ebuild,v 1.2 2005/11/04 21:19:18 mr_bones_ Exp $

inherit distutils

DESCRIPTION="An anti-spam filter using on Bayesian filtering"
HOMEPAGE="http://spambayes.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

RESTRICT="nomirror"

LICENSE="PSF-2.2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE=""

DEPEND=">=dev-lang/python-2.2.2"

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

