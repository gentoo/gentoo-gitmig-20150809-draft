# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/cryptsetup/cryptsetup-0.1-r1.ebuild,v 1.6 2005/03/25 13:18:02 kloeri Exp $

inherit kernel-mod

DESCRIPTION="Tool to setup encrypted devices with dm-crypt"
HOMEPAGE="http://www.saout.de/misc/dm-crypt/"
SRC_URI="http://www.saout.de/misc/dm-crypt/${PN}-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm hppa ia64 ppc s390 ~sparc x86 ~alpha"
IUSE=""

DEPEND=">=sys-fs/device-mapper-1.00.07-r1
	>=dev-libs/libgcrypt-1.1.42"

S=${WORKDIR}/${PN}-${PV}

pkg_setup() {
	if ! kernel-mod_configoption_present DM_CRYPT ; then
		ewarn "dm-crypt is not enabled in /usr/src/linux/.config"
		ewarn "please see $HOMEPAGE"
		ewarn "for details on how to enable dm-crypt for your kernel"
	fi
}

src_compile() {
	econf --bindir=/bin --disable-nls || die

	sed -i \
		-e 's|-lgcrypt|/usr/lib/libgcrypt.a|' \
		-e 's|-lgpg-error|/usr/lib/libgpg-error.a|' \
		Makefile src/Makefile
	sed -i -e 's|-lpopt|/usr/lib/libpopt.a|' src/Makefile

	emake || die
}

src_install() {
	make DESTDIR="${D}" install || die "install failed"

	newconfd ${FILESDIR}/cryptfs.confd cryptfs
	insinto /lib/rcscripts/addons
	doins "${FILESDIR}"/dm-crypt-{start,stop}.sh
}
