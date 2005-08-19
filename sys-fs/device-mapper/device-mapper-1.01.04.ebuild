# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/device-mapper/device-mapper-1.01.04.ebuild,v 1.1 2005/08/19 23:10:55 vapier Exp $

inherit eutils multilib

DESCRIPTION="Device mapper ioctl library for use with LVM2 utilities"
HOMEPAGE="http://sources.redhat.com/dm/"
SRC_URI="ftp://sources.redhat.com/pub/dm/${PN}.${PV}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE=""

DEPEND=""

S=${WORKDIR}/${PN}.${PV}

src_compile() {
	econf --sbindir=/sbin || die "econf failed"
	emake -j1 || die "compile problem"
}

src_install() {
	make install DESTDIR="${D}" || die

	# move shared libs to /
	mv "${D}"/usr/$(get_libdir) "${D}"/ || die "move libdir"
	dolib.a lib/ioctl/libdevmapper.a || die "dolib.a"
	gen_usr_ldscript libdevmapper.so

	insinto /etc
	doins "${FILESDIR}"/dmtab
	insinto /lib/rcscripts/addons
	doins "${FILESDIR}"/dm-start.sh

	dodoc INSTALL INTRO README VERSION WHATS_NEW
}
