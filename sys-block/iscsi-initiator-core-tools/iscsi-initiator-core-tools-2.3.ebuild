# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-block/iscsi-initiator-core-tools/iscsi-initiator-core-tools-2.3.ebuild,v 1.5 2010/09/27 11:46:12 cla Exp $

inherit eutils flag-o-matic

DESCRIPTION="iscsi-initiator-core is a full featured iSCSI Initiator stack."
#HOMEPAGE="http://iscsi-initiator-core.org/"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI="mirror://kernel/linux/utils/storage/iscsi/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND=""
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/fix-ldflags.patch"
}

src_compile() {
	cd "${S}"/ipyxd/
	append-flags -DLINUX -Iinclude/

	# parallel build failure as per bug #187243
	emake -j1 all AUTHFLAGS="${CFLAGS}" DEBUGFLAGS="${CFLAGS}" || die "failed to compile"
}

src_install() {
	dodoc HOWTO INSTALL README RELEASE_NOTES
	cd "${S}"/ipyxd/
	into /
	dosbin initiator_authd initiator_ctl initiator_iname
	dosbin scripts/iscsi* scripts/proc.iscsi* scripts/sysfs.iscsi-*
	newsbin scripts/install.channel iscsi-install-channel
	insinto /etc/iscsi
	newins conf/devicemaps-sysconfig devicemaps
	newins conf/initiator-sysconfig initiator
	newins conf/initiator_auth-sysconfig initiator_auth

	into /usr
	doman man/*.[15]
	dodoc scripts/rc.initiator
}

pkg_postinst() {
	ewarn "A gentoo init.d script is still needed for this package!"
	ewarn "See the rc.initiator script with the documentation for ideas."
}
