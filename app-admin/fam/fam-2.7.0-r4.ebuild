# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/fam/fam-2.7.0-r4.ebuild,v 1.21 2009/05/06 20:48:26 jer Exp $

inherit libtool eutils autotools

DESCRIPTION="FAM, the File Alteration Monitor"
HOMEPAGE="http://oss.sgi.com/projects/fam/"
SRC_URI="ftp://oss.sgi.com/projects/fam/download/stable/${P}.tar.gz
	mirror://gentoo/fam-2.7.0-dnotify.patch.bz2"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86"
IUSE=""

DEPEND=">=net-nds/portmap-5b-r6
	!app-admin/gamin"
PROVIDE="virtual/fam"

src_unpack() {
	unpack ${A}

	cd "${S}"

	# large file patch #76679
	epatch "${FILESDIR}/${P}-largefiles.patch"

	# dnotify patch #43027
	echo $WORKDIR
	epatch "${WORKDIR}/${P}-dnotify.patch"

	# Use limits correctly -#89478
	epatch "${FILESDIR}/${P}-limits.patch"

	# Fix gcc 4.1 problems
	epatch "${FILESDIR}/${P}-gcc41.patch"

	epatch "${FILESDIR}/${P}-gcc43.patch"

	eautoreconf
}

src_install() {

	make install DESTDIR="${D}" || die

	dosed "s:local_only = false:local_only = true:g" /etc/fam.conf

	doinitd "${FILESDIR}/famd"

	dodoc AUTHORS ChangeLog INSTALL NEWS TODO README

}

pkg_postinst() {

	elog "To enable fam on	 boot you will have to add it to the"
	elog "default profile, issue the following command as root to do so."
	elog
	elog "rc-update add famd default"

	# temporary warning for people upgrading
	# 6-12-03 foser <foser@gentoo.org>
	if [ -e /etc/init.d/fam ]
	then
		echo
		elog "IMPORTANT INFO FOR USERS UPGRADING FROM OLDER (<2.7.0) FAM VERSIONS :"
		elog
		elog "With the 2.7.0 version the fam daemon moved to sbin and was"
		elog "renamed from 'fam' to 'famd'. These changes are for consistency"
		elog "reasons also applied to the Gentoo init script. This means you"
		elog "will have to remove fam from the default runlevel and add famd."
		elog "This can be done by issueing the following commands :"
		elog
		elog "rc-update del fam"
		elog "rc-update add famd default"
		elog "rm /etc/init.d/fam"
		elog
		elog "The last command removes the old init script."
		echo
	fi

}
