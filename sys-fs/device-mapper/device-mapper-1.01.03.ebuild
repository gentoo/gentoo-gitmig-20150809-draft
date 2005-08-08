# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/device-mapper/device-mapper-1.01.03.ebuild,v 1.2 2005/08/08 11:19:25 ka0ttic Exp $

inherit eutils

DESCRIPTION="Device mapper ioctl library for use with LVM2 utilities"
HOMEPAGE="http://sources.redhat.com/dm/"
SRC_URI="ftp://sources.redhat.com/pub/dm/${PN}.${PV}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sparc ~x86"
IUSE=""

DEPEND=""

S=${WORKDIR}/${PN}.${PV}

src_compile() {
	econf || die "econf failed"
	# Parallel build doesn't work.
	emake -j1 || die "compile problem"
}

src_install() {
	einstall \
		sbindir="${D}/sbin" \
		libdir="${D}/$(get_libdir)" \
		|| die "install failed"

	# Please do not use $(get_libdir) here again, as it is where it is
	# _located_, and not to where it is installed!
	dolib.a "${S}"/lib/ioctl/libdevmapper.a
	# bug #4411
	gen_usr_ldscript libdevmapper.so || die "gen_usr_ldscript failed"

	insinto /etc
	doins "${FILESDIR}"/dmtab
	insinto /lib/rcscripts/addons
	doins "${FILESDIR}"/dm-start.sh

	dodoc INSTALL INTRO README VERSION WHATS_NEW
}
