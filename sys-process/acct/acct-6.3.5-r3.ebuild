# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-process/acct/acct-6.3.5-r3.ebuild,v 1.2 2008/10/26 05:38:29 vapier Exp $

inherit eutils

PATCH_VER="ts02-12"
MY_P=${P}-${PATCH_VER}
DESCRIPTION="GNU system accounting utilities"
HOMEPAGE="http://www.gnu.org/directory/acct.html"
SRC_URI="http://www.physik3.uni-rostock.de/tim/kernel/utils/acct/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~x86"
IUSE=""

DEPEND=""

S=${WORKDIR}/${MY_P}

src_compile() {
	econf --enable-linux-multiformat || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	# accton in / is only a temp workaround for #239748
	into /
	dosbin accton || die "dosbin failed"
	into /usr
	dobin ac lastcomm || die "dobin failed"
	dosbin dump-utmp dump-acct sa || die "dosbin failed"
	dosym /sbin/accton /usr/sbin/accton
	doinfo accounting.info
	doman {ac,lastcomm}.1 {accton,sa}.8
	dodoc AUTHORS ChangeLog INSTALL NEWS README ToDo
	keepdir /var/account
	newinitd "${FILESDIR}"/acct.rc6-6.3.5-r3 acct
	newconfd "${FILESDIR}"/acct.confd acct
}
