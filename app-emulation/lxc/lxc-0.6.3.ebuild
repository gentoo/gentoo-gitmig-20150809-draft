# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/lxc/lxc-0.6.3.ebuild,v 1.2 2009/11/14 19:23:22 swegener Exp $

EAPI="2"

inherit autotools eutils linux-info

DESCRIPTION="Linux Resource Containers Userspace Tools"
HOMEPAGE="http://lxc.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="sys-libs/libcap"
DEPEND="${RDEPEND}
	sys-kernel/linux-headers
	app-text/docbook-sgml-utils"

# TODO:
# - add checks for the various kernel features which have to be enabled

CONFIG_CHECK="CGROUPS CGROUP_NS NAMESPACES UTS_NS IPC_NS USER_NS PID_NS NET_NS"

src_prepare() {
	epatch "${FILESDIR}/0.6.2-as-needed.patch"
	eautoreconf
}

src_configure() {
	econf --localstatedir=/var --bindir=/usr/sbin --disable-static
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog CONTRIBUTING MAINTAINERS NEWS README TODO doc/FAQ.txt || die

	# The default files installed in /etc/lxc are just samples;
	# install them as documentation instead.
	mv "${D}"/etc/lxc "${D}"/usr/share/doc/${PF}/config-examples || die
	keepdir /etc/lxc /var/lib/lxc

	rm "${D}"/usr/sbin/lxc-{setcap,ls}

	find "${D}" -name '*.la' -delete
}

pkg_postinst() {
	ewarn "You may have to enable more than the kernel features this ebuild"
	ewarn "already checked for, depending on what you want to use."
	elog "If you want network you definetely have to enable the veth module"
	elog "and possibly also the macvlan (depending on how you want to do it)."
	elog "If you want the to be able to freeze containers you will also want"
	elog "the cgroup freezer."
}
