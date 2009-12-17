# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/ganeti/ganeti-2.0.5.ebuild,v 1.1 2009/12/17 17:05:20 ramereth Exp $

EAPI=2

inherit eutils confutils bash-completion

DESCRIPTION="Ganeti is a virtual server management software tool"
HOMEPAGE="http://code.google.com/p/ganeti/"
SRC_URI="http://ganeti.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="kvm xen drbd"

DEPEND="xen? ( >=app-emulation/xen-3.0 )
	kvm? ( app-emulation/qemu-kvm )
	drbd? ( >=sys-cluster/drbd-8.0 )
	dev-libs/openssl
	dev-python/pyopenssl
	dev-python/pyparsing
	dev-python/simplejson
	net-analyzer/arping
	net-misc/bridge-utils
	net-misc/openssh
	net-misc/socat
	sys-apps/iproute2
	sys-fs/lvm2"
RDEPEND="${DEPEND}"

src_prepare () {
	epatch "${FILESDIR}/${PN}-2.0.3-gentoo-brctl-path.patch"
}

pkg_setup () {
	confutils_require_any kvm xen
}

src_configure () {
	econf --localstatedir=/var \
		--docdir=/usr/share/doc/${P} \
		--with-ssh-initscript=/etc/init.d/sshd \
		--with-export-dir=/var/lib/ganeti-storage/export \
		--with-os-search-path=/usr/share/ganeti/os \
		--with-file-storage-dir=/var/lib/ganeti-storage/file
}

src_install () {
	emake DESTDIR="${D}" install || die "emake install failed"
	newinitd "${FILESDIR}"/ganeti2.initd ganeti
	dobashcompletion doc/examples/bash_completion ganeti
	dodoc DEVNOTES INSTALL NEWS README doc/*.rst doc/*.txt
	rm -rf "${D}"/usr/share/doc/ganeti
	docinto examples
	dodoc doc/examples/dumb-allocator doc/examples/ganeti.cron

	keepdir /var/{lib,log,run}/ganeti/
	keepdir /usr/share/ganeti/os/
	keepdir /var/lib/ganeti-storage/{export,file}/
}

pkg_postinst () {
	bash-completion_pkg_postinst
}
