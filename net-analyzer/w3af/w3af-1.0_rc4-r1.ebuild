# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/w3af/w3af-1.0_rc4-r1.ebuild,v 1.1 2010/12/29 11:22:21 hwoarang Exp $

EAPI=2

PYTHON_USE_WITH="sqlite"
PYTHON_DEPEND="2"

inherit multilib python versionator

MY_P=${PN}-"$(replace_version_separator 2 '-')"
DESCRIPTION="Web Application Attack and Audit Framework"
HOMEPAGE="http://w3af.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc gtk"

RDEPEND=">=dev-python/fpconst-0.7.2
	dev-python/lxml
	dev-python/nltk
	dev-python/pyopenssl
	dev-python/pyPdf
	dev-python/pysqlite
	dev-python/python-cluster
	dev-python/pyyaml
	dev-python/simplejson
	dev-python/soappy
	|| (
		net-analyzer/gnu-netcat
		net-analyzer/netcat
		net-analyzer/netcat6
		sys-apps/busybox )
	net-analyzer/scapy
	gtk? ( media-gfx/graphviz
		>dev-python/pygtk-2.0 )"

S=${WORKDIR}/${PN}

src_prepare(){
	rm -r extlib/{cluster,fpconst-0.7.2,nltk,nltk_contrib,pyPdf,scapy,simplejson,SOAPpy,yaml} || die
	rm readme/{GPL,INSTALL} || die
	rm plugins/attack/payloads/code/netcat || die #bug 349780
}

src_install() {
	insinto /usr/$(get_libdir)/w3af
	doins -r core extlib locales plugins profiles scripts tools w3af_gui w3af_console || die
	fperms +x /usr/$(get_libdir)/w3af/w3af_{gui,console} || die
	dobin "${FILESDIR}"/w3af_console || die
	if use gtk ; then
		dobin "${FILESDIR}"/w3af_gui || die
	fi
	#use flag doc is here because doc is bigger than 3 Mb
	if use doc ; then
		insinto /usr/share/doc/${PF}/
		doins -r readme/* || die
	fi
}
