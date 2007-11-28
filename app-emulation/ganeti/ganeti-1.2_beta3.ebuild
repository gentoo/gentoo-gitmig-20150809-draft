# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/ganeti/ganeti-1.2_beta3.ebuild,v 1.1 2007/11/28 17:16:32 hansmi Exp $

NEED_PYTHON=2.4

inherit python autotools eutils

MY_P=${P/_beta/b}
S="${WORKDIR}/${MY_P}"

DESCRIPTION="Ganeti is a virtual server management software tool built upon Xen"
HOMEPAGE="http://code.google.com/p/ganeti/"
SRC_URI="http://ganeti.googlecode.com/files/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=""
RDEPEND="
	>=app-emulation/xen-3.0
	dev-libs/openssl
	dev-python/pyopenssl
	dev-python/pyparsing
	dev-python/simplejson
	dev-python/twisted
	net-analyzer/arping
	net-misc/bridge-utils
	net-misc/openssh
	sys-apps/iproute2
	sys-cluster/drbd
	sys-fs/lvm2
	sys-fs/mdadm
"

src_unpack() {
	unpack "${A}"
	cd "${S}"

	eautoreconf
}

src_compile() {
	econf --localstatedir=/var --with-ssh-initscript=/etc/init.d/sshd || die
	emake || die
}

src_install() {
	make DESTDIR="${D}" install || die

	newinitd "${FILESDIR}/ganeti.initd" ganeti

	keepdir /var/{lib,log,run}/ganeti/
	keepdir /srv/ganeti/{os,export}/
}
