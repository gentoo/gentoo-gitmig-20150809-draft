# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-proxy/ntlmaps/ntlmaps-0.9.8-r1.ebuild,v 1.2 2005/01/09 09:12:01 corsair Exp $

inherit eutils

MY_P_URL="aps${PV//.}"
MY_P_VER="${PV/-r.*/}"
DESCRIPTION="NTLM proxy Authentication against MS proxy/web server"
HOMEPAGE="http://ntlmaps.sourceforge.net/"
SRC_URI="mirror://sourceforge/ntlmaps/${MY_P_URL}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~arm ~hppa ~ia64 ~ppc ~s390 ~x86 ~ppc64"
IUSE=""

RDEPEND=">=dev-lang/python-1.5"
DEPEND="${RDEPEND}
	>=sys-apps/portage-2.0.51"

S=${WORKDIR}/${MY_P_URL}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}.patch
}

src_install() {
	dodir /etc/conf.d
	dodir /usr/${PN}/lib
	# exes ------------------------------------------------------------------
	exeinto /usr/${PN}
	doexe main.py || die
	insinto /usr/${PN}/lib
	doins lib/* || die
	# doc -------------------------------------------------------------------
	dodoc Install.txt changelog.txt readme.txt research.txt
	insinto /usr/share/doc/${PF}/doc
	doins doc/*
	# conf ------------------------------------------------------------------
	newconfd ${S}/server.cfg ${PN}.cfg
	newinitd ${FILESDIR}/${PN}.init ${PN}
}
pkg_prerm() {
	einfo "Removing /etc/init.d/ntlmaps script and python compiled bytecode in /usr/ntlmaps dir"
	rm -f /usr/ntlmaps/*/*.py?
	rm -f /etc/init.d/ntlmaps
}
