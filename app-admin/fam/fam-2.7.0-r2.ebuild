# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/fam/fam-2.7.0-r2.ebuild,v 1.4 2004/11/12 08:42:52 lu_zero Exp $

inherit libtool eutils gnuconfig

DESCRIPTION="FAM, the File Alteration Monitor"
HOMEPAGE="http://oss.sgi.com/projects/fam/"
SRC_URI="ftp://oss.sgi.com/projects/fam/download/stable/${P}.tar.gz"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 arm hppa ia64 ~mips ppc ~ppc64 s390 sparc x86"
IUSE=""

DEPEND=">=net-nds/portmap-5b-r6
	!app-admin/gamin"
PROVIDE="virtual/fam"

src_unpack() {
	unpack ${A}

	cd ${S}
	# dnotify patch #43027
	epatch ${FILESDIR}/${P}-dnotify.patch

	# Fix permission problems with user* in FEATURES (#35307)
	chmod u+w ${S}/configure

	# Please do not remove this again - fixes $S and $D in libtool linker
	# scripts (.la files)
	cd ${S}; elibtoolize

	gnuconfig_update
}

src_install() {

	einstall || die

	dosed "s:local_only = false:local_only = true:g" /etc/fam.conf

	exeinto /etc/init.d
	doexe ${FILESDIR}/famd

	dodoc AUTHORS ChangeLog INSTALL NEWS TODO README

}

pkg_postinst() {

	einfo "To enable fam on  boot you will have to add it to the"
	einfo "default profile, issue the following command as root to do so."
	echo
	einfo "rc-update add famd default"

	# temporary warning for people upgrading
	# 6-12-03 foser <foser@gentoo.org>
	if [ -e /etc/init.d/fam ]
	then
		echo
		echo
		ewarn "IMPORTANT INFO FOR USERS UPGRADING FROM OLDER (<2.7.0) FAM VERSIONS :"
		echo
		einfo "With the 2.7.0 version the fam daemon moved to sbin and was"
		einfo "renamed from 'fam' to 'famd'. These changes are for consistency"
		einfo "reasons also applied to the Gentoo init script. This means you"
		einfo "will have to remove fam from the default runlevel and add famd."
		einfo "This can be done by issueing the following commands :"
		echo
		einfo "rc-update del fam"
		einfo "rc-update add famd default"
		einfo "rm /etc/init.d/fam"
		echo
		einfo "The last command removes the old init script."
	fi

}
