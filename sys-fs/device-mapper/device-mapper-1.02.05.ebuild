# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/device-mapper/device-mapper-1.02.05.ebuild,v 1.2 2006/04/24 18:15:48 kumba Exp $

inherit eutils multilib

DESCRIPTION="Device mapper ioctl library for use with LVM2 utilities"
HOMEPAGE="http://sources.redhat.com/dm/"
SRC_URI="ftp://sources.redhat.com/pub/dm/${PN}.${PV}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE="selinux"

DEPEND="selinux? ( sys-libs/libselinux )"

S=${WORKDIR}/${PN}.${PV}

src_compile() {
	econf --sbindir=/sbin $(use_enable selinux) || die "econf failed"
	emake || die "compile problem"
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

pkg_preinst() {
	local l=${ROOT}/$(get_libdir)/libdevmapper.so.1.01
	[[ -e ${l} ]] && cp "${l}" "${D}"/$(get_libdir)/
}

pkg_postinst() {
	preserve_old_lib_notify /$(get_libdir)/libdevmapper.so.1.01
}
