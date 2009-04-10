# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/multipath-tools/multipath-tools-0.4.7-r1.ebuild,v 1.2 2009/04/10 16:54:46 caleb Exp $

inherit eutils toolchain-funcs

DESCRIPTION="Device mapper target autoconfig"
HOMEPAGE="http://christophe.varoqui.free.fr/wiki/wakka.php?wiki=Home"
SRC_URI="http://christophe.varoqui.free.fr/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="|| (
		>=sys-fs/lvm2-2.02.45
		>=sys-fs/device-mapper-1.00.19-r1
	)
	sys-fs/udev
	sys-fs/sysfsutils"
DEPEND="${RDEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-build.patch
}

src_compile() {
	emake -j1 CC=$(tc-getCC) || die "emake failed"
}

src_install() {
	dodir /sbin /usr/share/man/man8
	make DESTDIR="${D}" install || die "install failed"

	insinto /etc
	newins "${S}"/multipath.conf.annotated multipath.conf
	fperms 644 /etc/udev/rules.d/40-multipath.rules
	newinitd "${FILESDIR}"/rc-multipathd multipathd

	dodoc AUTHOR ChangeLog FAQ README TODO
	docinto dmadm; dodoc README
	docinto kpartx; dodoc ChangeLog README
}

pkg_preinst() {
	# The dev.d script was previously wrong and is now removed (the udev rules
	# file does the job instead), but it won't be removed from live systems due
	# to cfgprotect.
	# This should help out a little...
	if [[ -e ${ROOT}/etc/dev.d/block/multipath.dev ]] ; then
		mkdir -p "${D}"/etc/dev.d/block
		echo "# Please delete this file. It is obsoleted by /etc/udev/rules.d/40-multipath.rules" \
			> "${D}"/etc/dev.d/block/multipath.dev
	fi
}
